import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_category_usecase.dart';
import '../../domain/usecases/get_event_category_usecase.dart';
import '../../domain/usecases/create_event_type_usecase.dart';
import 'event_category_event.dart';
import 'event_category_state.dart';

class EventCategoryBloc extends Bloc<EventCategoryEvent, EventCategoryState> {
  final GetEventCategoriesUseCase getEventCategoriesUseCase;
  final CreateEventCategoryUseCase createEventCategoryUseCase;
  final CreateEventTypeUseCase createEventTypeUseCase;

  EventCategoryBloc(this.getEventCategoriesUseCase,
      this.createEventCategoryUseCase, this.createEventTypeUseCase)
      : super(EventCategoryInitial()) {
    on<GetEventCategories>(_onGetEventCategories);
    on<CreateEventCategory>(_onCreateEventCategory);
    on<CreateEventType>(_onCreateEventType);
  }

  Future<void> _onGetEventCategories(
    GetEventCategories event,
    Emitter<EventCategoryState> emit,
  ) async {
    emit(EventCategoryLoading());
    final result = await getEventCategoriesUseCase.execute();
    result.fold(
      (error) => emit(EventCategoryError(error.userMessage)),
      (categories) => emit(EventCategoryLoaded(categories)),
    );
  }

  Future<void> _onCreateEventCategory(
    CreateEventCategory event,
    Emitter<EventCategoryState> emit,
  ) async {
    try {
      emit(EventCategoryLoading());
      final result = await createEventCategoryUseCase.execute(
        event.name,
        event.description,
      );

      await result.fold(
        (error) async => emit(EventCategoryError(error.userMessage)),
        (category) async {
          final categoriesResult = await getEventCategoriesUseCase.execute();
          await categoriesResult.fold(
            (error) async => emit(EventCategoryError(error.userMessage)),
            (categories) async => emit(EventCategoryLoaded(categories)),
          );
        },
      );
    } catch (e) {
      emit(EventCategoryError('Failed to create category'));
    }
  }

  Future<void> _onCreateEventType(
    CreateEventType event,
    Emitter<EventCategoryState> emit,
  ) async {
    try {
      print('Creating event type: ${event.name}');
      emit(EventCategoryLoading());

      final result = await createEventTypeUseCase.execute(
        event.name,
        event.description,
        event.categoryId,
      );

      print('Create event type result: $result');

      await result.fold(
        (error) async {
          print('Error creating event type: ${error.userMessage}');
          emit(EventCategoryError(error.userMessage));
        },
        (eventType) async {
          print('Successfully created event type: ${eventType.name}');
          final categoriesResult = await getEventCategoriesUseCase.execute();
          await categoriesResult.fold(
            (error) async => emit(EventCategoryError(error.userMessage)),
            (categories) async => emit(EventCategoryLoaded(categories)),
          );
        },
      );
    } catch (e) {
      print('Exception in _onCreateEventType: $e');
      emit(EventCategoryError('Failed to create event type'));
    }
  }
}
