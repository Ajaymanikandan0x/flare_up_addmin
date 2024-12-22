import 'package:dartz/dartz.dart';
import '../../../../core/error/app_error.dart';
import '../entities/event_category.dart';
import '../repositories/event_category_repository.dart';

class CreateEventTypeUseCase {
  final EventCategoryRepository repository;

  CreateEventTypeUseCase(this.repository);

  Future<Either<AppError, EventType>> execute(
    String name,
    String description,
    int categoryId,
  ) {
    return repository.createEventType(name, description, categoryId);
  }
} 