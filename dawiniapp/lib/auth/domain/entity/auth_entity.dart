class AuthEntity {
  final String email;
  final String password;

  AuthEntity({
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
