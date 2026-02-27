import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/providers/sync_provider.dart';
import '../../shared/widgets/role_guard.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final sync = context.watch<SyncProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Administrativo'),
        actions: [
          Center(child: Text('Pendências offline: ${sync.pending}')),
          IconButton(onPressed: () => sync.syncNow(), icon: const Icon(Icons.sync)),
          IconButton(onPressed: () => auth.signOut(), icon: const Icon(Icons.logout)),
        ],
      ),
      body: RoleGuard(
        roles: const ['admin', 'gestor', 'tecnico', 'supervisor'],
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            ListTile(title: Text('Módulo de Usinas (CRUD)')),
            ListTile(title: Text('Módulo de Turbinas (CRUD)')),
            ListTile(title: Text('Módulo de Checklists com Builder Dinâmico')),
            ListTile(title: Text('Módulo de Inspeções com captura de fotos e assinatura')),
          ],
        ),
      ),
    );
  }
}
