class EventCategory {
  final int id;
  final String name;
  final String description;
  final String status;
  final DateTime updatedAt;
  final List<EventType> eventTypes;

  EventCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.updatedAt,
    required this.eventTypes,
  });
}

class EventType {
  final int id;
  final String name;
  final String description;
  final String status;
  final DateTime updatedAt;

  EventType({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.updatedAt,
  });
}

class EventCategoryCreate {
  final String name;
  final String description;

  EventCategoryCreate({
    required this.name,
    required this.description,
  });
} 
