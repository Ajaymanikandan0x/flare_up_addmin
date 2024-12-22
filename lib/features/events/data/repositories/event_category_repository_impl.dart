import 'package:dartz/dartz.dart';
import '../../../../core/error/app_error.dart';
import '../../../../core/error/error_handler.dart';
import '../../domain/entities/event_category.dart';
import '../../domain/repositories/event_category_repository.dart';
import '../datasources/event_category_remote_data_source.dart';

class EventCategoryRepositoryImpl implements EventCategoryRepository {
  final EventCategoryRemoteDataSource remoteDataSource;

  EventCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, List<EventCategory>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(error);
    }
  }

  @override
  Future<Either<AppError, EventCategory>> createCategory(
      String name, String description) async {
    try {
      final category = await remoteDataSource.createCategory(name, description);
      return Right(category);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(error);
    }
  }

  @override
  Future<Either<AppError, void>> deleteCategory(String id) async {
    try {
      await remoteDataSource.deleteCategory(id);
      return const Right(null);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(error);
    }
  }

  @override
  Future<Either<AppError, EventCategory>> updateCategory(
      EventCategory category) async {
    try {
      final updatedCategory = await remoteDataSource.updateCategory(
        category.id.toString(),
        category.name,
        category.description,
      );
      return Right(updatedCategory);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(error);
    }
  }

  @override
  Future<Either<AppError, EventType>> createEventType(
    String name,
    String description,
    int categoryId,
  ) async {
    try {
      final eventType = await remoteDataSource.createEventType(
        name,
        description,
        categoryId,
      );
      return Right(eventType);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(error);
    }
  }
}
