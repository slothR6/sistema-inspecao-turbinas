import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/auth_provider.dart';
import 'core/providers/sync_provider.dart';
import 'core/utils/app_router.dart';
import 'shared/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const TurbineInspectionApp());
}

class TurbineInspectionApp extends StatelessWidget {
  const TurbineInspectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..bootstrap()),
        ChangeNotifierProvider(create: (_) => SyncProvider()..init()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp.router(
            title: 'Sistema de Inspeção de Turbinas',
            theme: AppTheme.light,
            routerConfig: buildRouter(authProvider),
          );
        },
      ),
    );
  }
}
