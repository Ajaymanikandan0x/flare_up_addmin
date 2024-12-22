import 'package:equatable/equatable.dart';

abstract class EventCategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEventCategories extends EventCategoryEvent {}

class CreateEventCategory extends EventCategoryEvent {
  final String name;
  final String description;

  CreateEventCategory({required this.name, required this.description});

  @override
  List<Object> get props => [name, description];
}

class CreateEventType extends EventCategoryEvent {
  final String name;
  final String description;
  final int categoryId;

  CreateEventType({
    required this.name,
    required this.description,
    required this.categoryId,
  });

  @override
  List<Object> get props => [name, description, categoryId];
}
