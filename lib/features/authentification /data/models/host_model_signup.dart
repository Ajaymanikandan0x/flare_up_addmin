import '../../../../core/error/app_error.dart';
import '../../domain/entities/user_entities_signup.dart';

class AdminModelSignup {
  final String role;
  final String fullName;
  final String userName;
  final String email;
  final String password;
  
  AdminModelSignup({
    required this.userName,
    required this.role,
    required this.fullName,
    required this.email,
    required this.password,
  });

  factory AdminModelSignup.fromJson(Map<String, dynamic> json) {
    try {
      // For OTP response, return input data
      if (json.containsKey('message')) {
        return AdminModelSignup(
          userName: json['username']?.toString() ?? '',
          fullName: json['fullname']?.toString() ?? '',
          role: json['role']?.toString() ?? '',
          email: json['email']?.toString() ?? '',
          password: json['password']?.toString() ?? '',
        );
      }
      
      // For regular response
      return AdminModelSignup(
        userName: json['username']?.toString() ?? '',
        fullName: json['fullname']?.toString() ?? '',
        role: json['role']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        password: json['password']?.toString() ?? '',
      );
    } catch (e) {
      throw AppError(
        userMessage: 'Failed to process registration data',
        technicalMessage: e.toString(),
        type: ErrorType.businessLogic,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'fullname': fullName,
      'email': email,
      'role': role,
      'password': password,
    };
  }

  AdminEntitiesSignup toEntity() {
    return AdminEntitiesSignup(
      username: userName,
      fullName: fullName,
      password: password,
      role: role,
      email: email,
    );
  }
}
