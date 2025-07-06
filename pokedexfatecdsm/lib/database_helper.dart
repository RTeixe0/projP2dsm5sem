import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/usuario.dart';
import 'models/pokemon.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuarios (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            senha TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE pokemons (
            id INTEGER PRIMARY KEY,
            nome TEXT,
            tipo TEXT,
            imagem TEXT
          )
        ''');

        await db.insert('usuarios', {'email': 'fatec@pokemon.com', 'senha': 'pikachu'});
      },
    );
  }

  Future<Usuario?> getUser(String email, String senha) async {
    final db = await database;
    final result = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    if (result.isNotEmpty) {
      return Usuario(
        id: result.first['id'] as int,
        email: email,
        senha: senha,
      );
    }
    return null;
  }

  Future<void> salvarPokemons(List<Pokemon> lista) async {
    final db = await database;
    for (var p in lista) {
      await db.insert(
        'pokemons',
        p.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Pokemon>> listarPokemons() async {
    final db = await database;
    final maps = await db.query('pokemons');
    return maps.map((e) => Pokemon.fromMap(e)).toList();
  }

  Future<void> sincronizarComAPI() async {
    final url = 'http://35.198.50.242:3000/pokemons';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final pokemons = data.map((e) => Pokemon.fromJson(e)).toList();
        await salvarPokemons(pokemons);
      }
    } catch (e) {
      print('Erro ao buscar da API: \$e');
    }
  }

  Future<List<Pokemon>> getPokemons() async {
    final db = await database;
    final result = await db.query('pokemons');
    return result.map((e) => Pokemon(
      id: e['id'] as int,
      nome: e['nome'] as String,
      tipo: e['tipo'] as String,
      imagem: e['imagem'] as String,
    )).toList();
  }
} 
