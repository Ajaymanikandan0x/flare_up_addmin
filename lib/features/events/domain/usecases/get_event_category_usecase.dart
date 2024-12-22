import 'package:dartz/dartz.dart';
import '../repositories/event_category_repository.dart';
import '../../../../core/error/app_error.dart';
import '../entities/event_category.dart';

class GetEventCategoriesUseCase {
  final EventCategoryRepository repository;
  GetEventCategoriesUseCase(this.repository);

  Future<Either<AppError, List<EventCategory>>> execute() {
    return repository.getCategories();
  }
}
