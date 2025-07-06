import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/pokemon.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  final dbHelper = DatabaseHelper();
  late Future<List<Pokemon>> _futurePokemons;

  @override
  void initState() {
    super.initState();
    _futurePokemons = _carregarPokemons();
  }

  Future<List<Pokemon>> _carregarPokemons() async {
    await dbHelper.sincronizarComAPI(); // tenta sincronizar com a API
    return await dbHelper.listarPokemons(); // carrega do SQLite (online ou offline)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokemons")),
      body: FutureBuilder<List<Pokemon>>(
        future: _futurePokemons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum Pokémon encontrado."));
          }

          final pokemons = snapshot.data!;
          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final p = pokemons[index];
              return Card(
                child: ListTile(
                  leading: Image.asset(p.imagem, width: 50),
                  title: Text(p.nome),
                  subtitle: Text(p.tipo),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
