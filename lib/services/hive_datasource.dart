import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/services/datasource.dart';

class HiveDatasource implements DataSource {
  late Future init;

  HiveDatasource() {
    init = initialise();
  }
  // Hive.box<Todo>('todos').clear()

  Future<void> initialise() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ToDoAdaptor());
    await Hive.openBox<Todo>('todos');
  }

  @override
  Future<List<Todo>> browse() async {
    await init;
    List<Todo> toDos = Hive.box<Todo>('todos').values.toList();
    return toDos;
  }

  @override
  Future<Todo> read(String id) async {
    await init;
    Box<Todo> box = Hive.box<Todo>('todos');
    return box.get(id) as Future<Todo>;
  }

  @override
  Future<bool> edit(Map<String, dynamic> todoMap) async {
    await init;
    Todo todo = Todo(
        internalID: todoMap['key'],
        name: todoMap['name'],
        description: todoMap['description'],
        completed: todoMap['completed'],
        dateCreated: todoMap['dateCreated']);
    Hive.box<Todo>('todos').putAt(int.parse(todo.internalID ?? ""), todo);
    return true;
  }

  @override
  Future<bool> add(Map<String, dynamic> todoMap) async {
    await init;
    Box<Todo> box = Hive.box<Todo>('todos');
    Todo todo = Todo(
        name: todoMap['name'],
        description: todoMap['description'],
        dateCreated: todoMap['dateCreated']);
    box.add(todo);
    return true;
  }

  @override
  Future<bool> delete(Map<String, dynamic> todoMap) async {
    await init;
    if (Hive.box<Todo>("todos").length <= 1) {
      Hive.box<Todo>("todos").deleteAt(0);
    } else {
      Hive.box<Todo>("todos").deleteAt(int.parse(todoMap['key']));
    }
    return true;
  }
}
