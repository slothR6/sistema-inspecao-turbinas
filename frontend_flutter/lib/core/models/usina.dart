class Usina {
  const Usina({
    required this.id,
    required this.nome,
    required this.cliente,
    required this.localizacao,
    required this.ativo,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String nome;
  final String cliente;
  final String localizacao;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Usina.fromMap(String id, Map<String, dynamic> map) => Usina(
        id: id,
        nome: map['nome'] as String? ?? '',
        cliente: map['cliente'] as String? ?? '',
        localizacao: map['localizacao'] as String? ?? '',
        ativo: map['ativo'] as bool? ?? true,
        createdAt: DateTime.tryParse(map['created_at']?.toString() ?? '') ?? DateTime.now(),
        updatedAt: DateTime.tryParse(map['updated_at']?.toString() ?? '') ?? DateTime.now(),
      );

  Map<String, dynamic> toMap() => {
        'nome': nome,
        'cliente': cliente,
        'localizacao': localizacao,
        'ativo': ativo,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
