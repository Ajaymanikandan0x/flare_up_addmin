


import '../entities/user_entities_signup.dart';
import '../entities/user_model_signin.dart';

abstract class AuthRepositoryDomain {
  Future<AdminEntitySignIn> login(
      {required String username, required String password});
  Future<AdminEntitiesSignup> signup({
    required String username,
    required String fullName,
    required String role,
    required String email,
    required String password,
  });

  Future<void> logout();


 

}
