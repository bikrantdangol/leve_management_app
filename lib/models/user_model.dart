class UserModel {
  final String uid;
  final String email;
  final String name;
  final bool isAdmin;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.isAdmin = false,  // Hardcode admin logic later
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'isAdmin': isAdmin,
    };
  }
}