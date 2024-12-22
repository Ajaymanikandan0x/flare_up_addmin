import 'package:equatable/equatable.dart';

import '../../domain/entities/event_category.dart';

abstract class EventCategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class EventCategoryInitial extends EventCategoryState {}

class EventCategoryLoading extends EventCategoryState {}

class EventCategoryLoaded extends EventCategoryState {
  final List<EventCategory> categories;

  EventCategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class EventCategoryError extends EventCategoryState {
  final String message;

  EventCategoryError(this.message);

  @override
  List<Object> get props => [message];
}