import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveType(typeId: 0)
  final String id;
  @HiveType(typeId: 1)
  final String name;
  @HiveType(typeId: 2)
  final String description;
  @HiveType(typeId: 3)
  final String dateCreated;
  @HiveType(typeId: 4)
  final bool completed;

  Todo({
    this.id = "",
    required this.name,
    required this.description,
    this.completed = false,
    required this.dateCreated,
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
}

class ToDoAdaptor extends TypeAdapter<Todo> {
  @override
  Todo read(BinaryReader reader) {
    return Todo(
        id: reader.read(),
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
