import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  StreamSubscription<User?>? _sub;

  AppUser? profile;
  User? firebaseUser;
  bool loading = true;

  bool get isAuthenticated => firebaseUser != null && profile != null;

  Future<void> bootstrap() async {
    _sub = _authService.authChanges().listen((user) async {
      firebaseUser = user;
      if (user != null) {
        profile = await _authService.loadProfile(user.uid);
      } else {
        profile = null;
      }
      loading = false;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) => _authService.signIn(email, password);

  Future<void> signOut() => _authService.signOut();

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
