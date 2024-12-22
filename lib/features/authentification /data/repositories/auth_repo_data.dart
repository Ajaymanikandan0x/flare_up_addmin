import '../../../../core/error/app_error.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/user_entities_signup.dart';
import '../../domain/entities/user_model_signin.dart';
import '../../domain/repositories/auth_repo_domain.dart';
import '../datasources/remote_data.dart';
import '../../../../core/error/error_handler.dart';

class AdminRepositoryImpl implements AuthRepositoryDomain {
  final AdminRemoteDatasource _remoteDatasource;

  AdminRepositoryImpl(this._remoteDatasource);

  @override
  Future<AdminEntitySignIn> login(
      {required String username, required String password}) async {
    try {
      final response = await _remoteDatasource.login(
        username: username,
        password: password,
      );

      if (response.success) {
        final host = response.data!.toEntity();
        
        // Add role validation
        if (host.role != 'admin') {
          throw AppError(
            userMessage: 'Access denied. Invalid host role.',
            type: ErrorType.authentication
          );
        }
        
        return host;
      }

      Logger.error('Login failed', {
        'statusCode': response.statusCode,
        'message': response.message,
        'data': response.data
      });

      throw AppError(
        userMessage: 'Incorrect username or password',
        technicalMessage: 'API Response: ${response.message}',
        type: ErrorType.authentication
      );
    } catch (e) {
      Logger.error('Login error', e);

      if (e is AppError) {
        Logger.error('AppError details', {
          'type': e.type,
          'technicalMessage': e.technicalMessage,
          'metadata': e.metadata
        });
        rethrow;
      }

      // For any other errors, show generic message but log full details
      throw AppError(
          userMessage: 'Unable to sign in. Please try again.',
          technicalMessage: e.toString(),
          type: ErrorType.authentication);
    }
  }

  @override
  Future<AdminEntitiesSignup> signup({
    required String username,
    required String fullName,
    required String role,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDatasource.signUp(
        username: username,
        fullName: fullName,
        role: role,
        email: email,
        password: password,
      );

      if (response.success) {
        return AdminEntitiesSignup(
          username: username,
          fullName: fullName,
          password: password,
          role: role,
          email: email,
        );
      }

      throw AppError(
        userMessage: response.message ?? 'Unable to create account',
        type: ErrorType.businessLogic,
      );
    } catch (e) {
      Logger.error('Repository signup error', e);
      throw ErrorHandler.handle(e,
          customUserMessage: 'Failed to create account');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDatasource.logout();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

}
