import '../models/user_model.dart';

class AuthService {
  // In-memory storage: Map of email -> UserModel
  static final Map<String, UserModel> _users = {};

  // Simulated unique ID generator
  int _userIdCounter = 0;

  UserModel? get currentUser => null; // Not used without Firebase, use provider for current user

  Future<UserModel?> register(String name, String email, String password) async {
    if (_users.containsKey(email)) {
      throw Exception('User already exists');
    }
    final uid = '${email}_${_userIdCounter++}';
    final user = UserModel(
      uid: uid,
      email: email,
      name: name,
      isAdmin: email == 'admin@gmail.com', // Simple hardcoded admin
    );
    _users[email] = user;
    return user;
  }

  Future<UserModel?> login(String email, String password) async {
    return _users[email]; // Simple: no password check for demo
  }

  Future<void> logout() async {
    // No-op for in-memory
  }
}