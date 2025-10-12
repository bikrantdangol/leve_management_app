import '../models/user_model.dart';

class AuthService {
  // Stores users in memory, using email as the key
  static final Map<String, UserModel> _users = {};

  // Used to create a new user ID every time
  int _userIdCounter = 0;

  UserModel? get currentUser => null; // Placeholder: use Provider to access current user (no Firebase)

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
    // Not needed — user data is only stored in memory
  }
}