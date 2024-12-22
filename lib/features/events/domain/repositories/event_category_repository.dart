import 'package:dartz/dartz.dart';
import '../../../../core/error/app_error.dart';
import '../entities/event_category.dart';

abstract class EventCategoryRepository {
  Future<Either<AppError, List<EventCategory>>> getCategories();
  Future<Either<AppError, EventCategory>> createCategory(
      String name, String description);
  Future<Either<AppError, void>> deleteCategory(String id);
  Future<Either<AppError, EventCategory>> updateCategory(
      EventCategory category);
  Future<Either<AppError, EventType>> createEventType(
      String name, String description, int categoryId);
}
