import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/auth/login_page.dart';
import '../../modules/dashboard/dashboard_page.dart';
import '../../modules/inspecoes/inspection_page.dart';
import '../providers/auth_provider.dart';

GoRouter buildRouter(AuthProvider authProvider) {
  return GoRouter(
    initialLocation: '/dashboard',
    refreshListenable: authProvider,
    redirect: (context, state) {
      if (authProvider.loading) return null;
      final isLogin = state.matchedLocation == '/login';
      if (!authProvider.isAuthenticated && !isLogin) return '/login';
      if (authProvider.isAuthenticated && isLogin) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/dashboard', builder: (_, __) => const DashboardPage()),
      GoRoute(path: '/inspecoes/:id', builder: (_, state) => InspectionPage(id: state.pathParameters['id']!)),
    ],
  );
}
