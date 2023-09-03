import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/services/todo_datasource.dart';

class HiveDatasource implements TodoDataSource {
  late Future init;

  HiveDatasource() {
    init = initialise();
  }

  Future<void> initialise() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ToDoAdaptor());
    await Hive.openBox<Todo>('todos');
  }

  @override
  Future<bool> add(Todo todo) async {
    await init;
    Box<Todo> box = Hive.box<Todo>('todos');
    box.add(todo);
    return true;
  }

  @override
  Future<List<Todo>> browse() async {
    await init;
    Box<Todo> box = Hive.box<Todo>('todos');
    return box.values.toList();
  }

  @override
  Future<bool> delete(Todo todo) async {
    await init;
    todo.delete();
    return true;
  }

  @override
  Future<bool> edit(Todo todo) async {
    await init;
    todo.save();
    return true;
  }

  @override
  Future<Todo> read(String id) async {
    await init;
    Box<Todo> box = Hive.box<Todo>('todos');
    return box.get(id) as Future<Todo>;
  }
}
