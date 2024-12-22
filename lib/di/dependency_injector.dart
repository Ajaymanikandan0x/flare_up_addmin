import 'package:dio/dio.dart';
import '../core/error/error_handler_service.dart';
import '../core/network/network_service.dart';
import '../core/storage/secure_storage_service.dart';
import '../features/authentification /data/datasources/remote_data.dart';
import '../features/authentification /data/repositories/auth_repo_data.dart';
import '../features/authentification /domain/usecases/login_usecase.dart';
import '../features/authentification /domain/usecases/logout_usecase.dart';
import '../features/authentification /domain/usecases/signup_usecase.dart';
import '../features/authentification /presentation/bloc/auth_bloc.dart';
import '../features/events/data/datasources/event_category_remote_data_source.dart';
import '../features/events/data/repositories/event_category_repository_impl.dart';
import '../features/events/domain/usecases/create_category_usecase.dart';
import '../features/events/domain/usecases/create_event_type_usecase.dart';
import '../features/events/domain/usecases/get_event_category_usecase.dart';
import '../features/events/presentation/bloc/event_category_bloc.dart';

class DependencyInjector {
  static final DependencyInjector _instance = DependencyInjector._internal();
  factory DependencyInjector() => _instance;
  DependencyInjector._internal();

  late final EventCategoryBloc eventCategoryBloc;
  late final AuthBloc authBloc;
  
  void setup() {
    final dio = Dio();
    final networkService = NetworkService(dio);
    final storageService = SecureStorageService();
    final errorHandler = AppErrorHandlerService();
    
    // Auth Dependencies
    final adminRemoteDataSource = AdminRemoteDatasource(networkService);
    final authRepository = AdminRepositoryImpl(adminRemoteDataSource);
    
    // Auth Use Cases
    final loginUseCase = LoginUseCase(authRepository);
    final signupUseCase = SignupUseCase(authRepository);
    final logoutUseCase = LogoutUseCase(authRepository);

    // Auth Bloc
    authBloc = AuthBloc(
      loginUseCase: loginUseCase,
      signupUseCase: signupUseCase,
      logoutUseCase: logoutUseCase,
      storageService: storageService,
      authRepository: authRepository,
      errorHandler: errorHandler,
    );

    // Event Category Dependencies (existing code)
    final eventCategoryDataSource = EventCategoryRemoteDataSourceImpl(dio: dio);
    final eventCategoryRepository = EventCategoryRepositoryImpl(
      remoteDataSource: eventCategoryDataSource,
    );
    
    final getEventCategoriesUseCase = GetEventCategoriesUseCase(eventCategoryRepository);
    final createEventCategoryUseCase = CreateEventCategoryUseCase(eventCategoryRepository);
    final createEventTypeUseCase = CreateEventTypeUseCase(eventCategoryRepository);
    
    eventCategoryBloc = EventCategoryBloc(
      getEventCategoriesUseCase,
      createEventCategoryUseCase,
      createEventTypeUseCase,
    );
  }
} 