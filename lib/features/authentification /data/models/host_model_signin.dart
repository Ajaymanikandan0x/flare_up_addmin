import '../../domain/entities/user_model_signin.dart';

class AdminModelSignIn {
  final int id;
  final String accessToken;
  final String refreshToken;
  final String username;
  final String email;
  final String role;

  AdminModelSignIn({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  factory AdminModelSignIn.fromJson(Map<String, dynamic> json) {
    return AdminModelSignIn(
      id: json['id'] ?? 0,
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }

  AdminEntitySignIn toEntity() {
    return AdminEntitySignIn(
      id: id,
      accessToken: accessToken,
      refreshToken: refreshToken,
      username: username,
      email: email,
      role: role,
    );
  }
}
