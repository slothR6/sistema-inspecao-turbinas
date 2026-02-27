import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 380,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Acesso ao Sistema'),
                  TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
                  TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Senha'), obscureText: true),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _loading ? null : _signIn,
                    child: Text(_loading ? 'Entrando...' : 'Entrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    setState(() => _loading = true);
    try {
      await context.read<AuthProvider>().signIn(_emailController.text.trim(), _passwordController.text);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}
