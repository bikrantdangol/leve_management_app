import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;

  UserModel? get user => _user;

  Future<bool> login(String email, String password) async {
    try {
      final user = await _authService.login(email, password);
      if (user != null) {
        _user = user;
        notifyListeners();
        return true;
      }
    } catch (e) {
      // Handle error
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      final user = await _authService.register(name, email, password);
      if (user != null) {
        _user = user;
        notifyListeners();
        return true;
      }
    } catch (e) {
      // Handle error, e.g., user exists
    }
    return false;
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}