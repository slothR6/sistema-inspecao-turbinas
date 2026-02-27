import 'package:flutter/material.dart';

class InspectionPage extends StatelessWidget {
  const InspectionPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inspeção $id')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Renderização dinâmica baseada em checklist JSON.'),
          SizedBox(height: 16),
          Placeholder(fallbackHeight: 150),
          SizedBox(height: 16),
          Text('Área para captura de imagem e assinatura digital.'),
        ],
      ),
    );
  }
}
