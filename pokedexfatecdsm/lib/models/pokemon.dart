class Pokemon {
  final int id;
  final String nome;
  final String tipo;
  final String imagem;

  Pokemon({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.imagem,
  });

  // Para salvar no SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
      'imagem': imagem,
    };
  }

  // Para recuperar do SQLite
  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'] as int,
      nome: map['nome'] as String,
      tipo: map['tipo'] as String,
      imagem: map['imagem'] as String,
    );
  }

  // Para recuperar da API (JSON)
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      nome: json['nome'],
      tipo: json['tipo'],
      imagem: 'assets/images/${json['imagem']}', // converte nome simples para caminho local
    );
  }
}
