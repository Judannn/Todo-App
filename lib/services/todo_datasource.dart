import 'package:test_app/models/todo.dart';

//Interface for all
abstract class TodoDataSource {
  Future<List<Todo>> browse();
  Future<Todo> read(String id);
  Future<bool> edit(Todo todo);
  Future<bool> add(Todo todo);
  Future<bool> delete(Todo todo);
}
