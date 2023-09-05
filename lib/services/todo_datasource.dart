import 'package:test_app/models/todo.dart';
import 'package:test_app/services/hive_datasource.dart';

//Interface for all
abstract class TodoDataSource {
  Future<List<Todo>> browse(ListFilter filter);
  Future<Todo> read(String id);
  Future<bool> edit(Todo todo);
  Future<bool> add(Todo todo);
  Future<bool> delete(Todo todo);
}
