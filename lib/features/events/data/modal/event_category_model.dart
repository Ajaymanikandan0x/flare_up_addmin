import '../../domain/entities/event_category.dart';

class EventCategoryModel extends EventCategory {
  EventCategoryModel({
    required int id,
    required String name,
    required String description,
    required String status,
    required DateTime updatedAt,
    required List<EventType> eventTypes,
  }) : super(
          id: id,
          name: name,
          description: description,
          status: status,
          updatedAt: updatedAt,
          eventTypes: eventTypes,
        );

  factory EventCategoryModel.fromJson(Map<String, dynamic> json) {
    return EventCategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'Active',
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      eventTypes: (json['event_types'] as List<dynamic>?)
              ?.map((type) => EventTypeModel.fromJson(type))
              .toList() ??
          [],
    );
  }
}

class EventTypeModel extends EventType {
  EventTypeModel({
    required int id,
    required String name,
    required String description,
    required String status,
    required DateTime updatedAt,
  }) : super(
          id: id,
          name: name,
          description: description,
          status: status,
          updatedAt: updatedAt,
        );

  factory EventTypeModel.fromJson(Map<String, dynamic> json) {
    return EventTypeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'Active',
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class EventCategoryCreateModel extends EventCategoryCreate {
  EventCategoryCreateModel({
    required String name,
    required String description,
  }) : super(
          name: name,
          description: description,
        );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
} 