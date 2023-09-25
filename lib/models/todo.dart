import 'package:test_app/models/hive_todo.dart';

class Todo {
  late String id;
  final String name;
  final String description;
  final String dateCreated;
  bool completed;

  Todo({
    required this.name,
    required this.description,
    required this.dateCreated,
    this.id = "",
    this.completed = false,
  });

  @override
  String toString() {
    // return name + " (" + description + ") "; old operation on string
    return "$name - ($description) "; //String interpolation
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dateCreated': dateCreated,
      'completed': completed,
    };
  }

  HiveTodo toHiveTodo() {
    return HiveTodo(
        name: name,
        description: description,
        dateCreated: dateCreated,
        completed: completed);
  }

  factory Todo.fromMap(Map<dynamic, dynamic> mapData) {
    return Todo(
        id: mapData['id'],
        name: mapData['name'],
        description: mapData['description'],
        completed: mapData['completed'],
        dateCreated:
            mapData.containsKey('dateCreated') ? mapData['dateCreated'] : "");
  }
}
