import 'package:flutter/material.dart';
import '../models/user_model.dart'; 
import '../services/auth_service.dart';

/// This provider manages user authentication and user state
class UserProvider extends ChangeNotifier {

  // Instance of the AuthService to handle backend auth logic
  final AuthService _authService = AuthService();

  // Private variable to store the currently logged-in user
  UserModel? _user;

  // Public getter to expose the current user to other parts of the app
  UserModel? get user => _user;

  /// Logs the user in with email and password
  /// Returns true if login is successful, otherwise false
  Future<bool> login(String email, String password) async {
    try {

      // Call the AuthService to perform login
      final user = await _authService.login(email, password);

      // If a user is returned (login successful), store it and notify listeners
      if (user != null) {
        _user = user;
        notifyListeners(); // Notify the UI that user data has changed
        return true;
      }
    } catch (e) {
      // Handle login error (e.g., show snackbar or log error)
    }
    return false;
  }

  /// Registers a new user with name, email, and password
  /// Returns true if registration is successful, otherwise false
  Future<bool> register(String name, String email, String password) async {
    try {

      // Call the AuthService to perform registration
      final user = await _authService.register(name, email, password);

      // If registration was successful, set the user and notify listeners
      if (user != null) {
        _user = user;
        notifyListeners(); // Notify the UI
        return true;
      }
    } catch (e) {
      // Handle registration errors (e.g., email already in use)
    }
    return false;
  }

  /// Logs the current user out
  /// Clears the user data and notifies the UI
  Future<void> logout() async {
    await _authService.logout(); // Call service to handle logout (e.g., clear session/token)
    _user = null;                // Clear the stored user
    notifyListeners();           // Notify UI that user is now null (logged out)
  }
}
