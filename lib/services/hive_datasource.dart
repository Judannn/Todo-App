import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/models/hive_todo.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/services/datasource.dart';

class HiveDatasource implements DataSource {
  late Future init;

  HiveDatasource() {
    init = initialise();
  }

  Future<void> initialise() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveToDoAdaptor());
    await Hive.openBox<HiveTodo>('todos');
  }

  @override
  Future<List<Todo>> browse() async {
    await init;
    List<Todo> todos = [];
    List<HiveTodo> hiveTodos = Hive.box<HiveTodo>('todos').values.toList();
    for (HiveTodo todo in hiveTodos) {
      todos.add(todo.toAppTodo());
    }
    return todos;
  }

  @override
  Future<void> edit(Todo todo) async {
    await init;
    HiveTodo? hiveTodo = Hive.box<HiveTodo>('todos').get(int.parse(todo.id));
    if (hiveTodo != null) {
      hiveTodo.name = todo.name;
      hiveTodo.description = todo.description;
      hiveTodo.completed = todo.completed;
      hiveTodo.dateCreated = todo.dateCreated;
      hiveTodo.save();
    } else {
      throw Exception('Todo not found');
    }
  }

  @override
  Future<void> add(Todo todo) async {
    await init;
    Box<HiveTodo> box = Hive.box<HiveTodo>('todos');
    HiveTodo hiveTodo = HiveTodo(
        name: todo.name,
        description: todo.description,
        dateCreated: todo.dateCreated);
    box.add(hiveTodo);
  }

  @override
  Future<void> delete(Todo todo) async {
    HiveTodo? hiveTodo = Hive.box<HiveTodo>('todos').get(int.parse(todo.id));
    if (hiveTodo != null) {
      hiveTodo.delete();
    } else {
      throw Exception('Todo not found');
    }
  }
}
