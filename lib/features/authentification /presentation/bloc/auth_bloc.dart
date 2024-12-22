import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/app_error.dart';
import '../../../../core/error/error_handler_service.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/repositories/auth_repo_domain.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

import '../../domain/usecases/signup_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final LogoutUseCase logoutUseCase;
  final SecureStorageService storageService;
  final AuthRepositoryDomain authRepository;
  final ErrorHandlerService errorHandler;

  AuthBloc({
    required this.loginUseCase,
    required this.signupUseCase,

    required this.logoutUseCase,
    required this.storageService,
    required this.authRepository,
 
    required this.errorHandler,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<SignupEvent>(_onSignupEvent);
  
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userEntity = await loginUseCase.call(
        username: event.username,
        password: event.password,
      );

      if (userEntity.role != 'admin') {
        throw AppError(
            userMessage: 'Access denied. Invalid user role.',
            type: ErrorType.authentication);
      }

      await storageService.saveTokens(
        accessToken: userEntity.accessToken,
        refreshToken: userEntity.refreshToken,
        userId: userEntity.id.toString(),
      );

      emit(AuthSuccess(userEntity: userEntity, message: 'Login successful!'));
    } catch (e) {
      errorHandler.logError(e as Exception, StackTrace.current);
      final userMessage = errorHandler.getReadableError(e);
      emit(AuthFailure(error: userMessage));
    }
  }

  Future<void> _onSignupEvent(
      SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      Logger.debug('Starting signup process for ${event.username}');

      await signupUseCase.call(
          username: event.username,
          fullName: event.fullName,
          email: event.email,
          password: event.password,
          role: event.role);

      Logger.debug('Signup successful');
      emit(SignupSuccess(
          email: event.email, message: 'Account created successfully!'));
    } on AppError catch (e) {
      Logger.error('Signup failed with AppError', e);
      emit(AuthFailure(error: e.userMessage));
    } catch (e) {
      Logger.error('Signup failed with unexpected error', e);
      emit(const AuthFailure(
          error: 'Failed to create account. Please try again.'));
    }
  }


 
}
