class Usuario {
  final int? id;
  final String email;
  final String senha;

  Usuario({this.id, required this.email, required this.senha});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'senha': senha,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] as int?,
      email: map['email'] as String,
      senha: map['senha'] as String,
    );
  }
}
