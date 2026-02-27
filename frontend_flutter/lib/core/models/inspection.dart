class Inspection {
  const Inspection({
    required this.id,
    required this.turbinaId,
    required this.checklistId,
    required this.tecnicoId,
    required this.supervisorId,
    required this.status,
    required this.dataInicio,
    this.dataFim,
    required this.respostasJson,
    required this.fotos,
    this.assinaturaTecnicoUrl,
    this.assinaturaSupervisorUrl,
    this.pdfUrl,
  });

  final String id;
  final String turbinaId;
  final String checklistId;
  final String tecnicoId;
  final String supervisorId;
  final String status;
  final DateTime dataInicio;
  final DateTime? dataFim;
  final Map<String, dynamic> respostasJson;
  final List<String> fotos;
  final String? assinaturaTecnicoUrl;
  final String? assinaturaSupervisorUrl;
  final String? pdfUrl;
}
