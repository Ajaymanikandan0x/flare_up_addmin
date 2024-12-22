import 'package:dartz/dartz.dart';
import '../repositories/event_category_repository.dart';
import '../../../../core/error/app_error.dart';
import '../entities/event_category.dart';

class CreateEventCategoryUseCase {
  final EventCategoryRepository repository;

  CreateEventCategoryUseCase(this.repository);

  Future<Either<AppError, EventCategory>> execute(String name, String description) {
    return repository.createCategory(name, description);
  }
}
