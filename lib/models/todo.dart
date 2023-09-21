import 'package:hive_flutter/hive_flutter.dart';

class Todo extends HiveObject {
  @HiveType(typeId: 0)
  late String? internalID;

  String get id {
    if (key != null) return key.toString();
    return internalID ?? "Not Provided";
  }

  @HiveType(typeId: 1)
  final String name;
  @HiveType(typeId: 2)
  final String description;
  @HiveType(typeId: 3)
  final String dateCreated;
  @HiveType(typeId: 4)
  bool completed;

  Todo({
    required this.name,
    required this.description,
    required this.dateCreated,
    this.completed = false,
    this.internalID = "",
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
      'completed': completed ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> mapData) {
    bool completed;

    if (mapData['completed'] is int) {
      completed = mapData['completed'] != 0;
    } else {
      completed = mapData['completed'] ?? false;
    }

    Todo todo = Todo(
        internalID: mapData['id'],
        name: mapData['name'],
        description: mapData['description'],
        completed: completed,
        dateCreated: mapData['dateCreated']);
    return todo;
  }
}

class ToDoAdaptor extends TypeAdapter<Todo> {
  @override
  Todo read(BinaryReader reader) {
    return Todo(
        internalID: reader.read(),
        name: reader.read(),
        description: reader.read(),
        dateCreated: reader.read(),
        completed: reader.read());
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.description);
    writer.write(obj.dateCreated);
    writer.write(obj.completed);
  }
}
