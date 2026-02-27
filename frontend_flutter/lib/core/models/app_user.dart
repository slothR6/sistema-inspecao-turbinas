class AppUser {
  const AppUser({
    required this.id,
    required this.nome,
    required this.email,
    required this.role,
    required this.ativo,
  });

  final String id;
  final String nome;
  final String email;
  final String role;
  final bool ativo;

  factory AppUser.fromMap(String id, Map<String, dynamic> map) => AppUser(
        id: id,
        nome: map['nome'] as String? ?? '',
        email: map['email'] as String? ?? '',
        role: map['role'] as String? ?? 'tecnico',
        ativo: map['ativo'] as bool? ?? true,
      );

  Map<String, dynamic> toMap() => {
        'nome': nome,
        'email': email,
        'role': role,
        'ativo': ativo,
      };
}
