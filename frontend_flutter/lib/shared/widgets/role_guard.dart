import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';

class RoleGuard extends StatelessWidget {
  const RoleGuard({super.key, required this.roles, required this.child});

  final List<String> roles;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final role = context.watch<AuthProvider>().profile?.role;
    if (role == null || !roles.contains(role)) {
      return const Center(child: Text('Acesso negado para este perfil.'));
    }
    return child;
  }
}
