import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/models/todo.dart';

class HiveTodo extends HiveObject {
  @HiveType(typeId: 0)
  String name;
  @HiveType(typeId: 1)
  String description;
  @HiveType(typeId: 2)
  String dateCreated;
  @HiveType(typeId: 3)
  bool completed;

  HiveTodo({
    required this.name,
    required this.description,
    required this.dateCreated,
    this.completed = false,
  });

  @override
  String toString() {
    // return name + " (" + description + ") "; old operation on string
    return "$name - ($description) "; //String interpolation
  }

  Todo toAppTodo() {
    return Todo(
        id: key.toString(),
        name: name,
        description: description,
        completed: completed,
        dateCreated: dateCreated);
  }
}

class HiveToDoAdaptor extends TypeAdapter<HiveTodo> {
  @override
  HiveTodo read(BinaryReader reader) {
    return HiveTodo(
      name: reader.read(),
      description: reader.read(),
      dateCreated: reader.read(),
      completed: reader.read(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, HiveTodo obj) {
    writer.write(obj.name);
    writer.write(obj.description);
    writer.write(obj.dateCreated);
    writer.write(obj.completed);
  }
}
