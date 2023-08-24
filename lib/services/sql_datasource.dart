import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/services/datasource.dart';

class SQLDatasource implements DataSource {
  late Database database;
  late Future init;

  SQLDatasource() {
    init = initialise();
  }

  Future initialise() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'todo_data.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY, name TEXT, description INTEGER)');
      },
    );
  }

  @override
  Future<bool> add(Todo todo) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> browse() async {
    await init; //wait for init completion before attempting to fetch data

    List<Map<String, dynamic>> maps = await database.query('todos');
    return List.generate(
        maps.length,
        (index) => Todo(
              id: maps[index]['id'],
              name: maps[index]['name'],
              description: maps[index]['description'],
              completed: maps[index]['completed'] == 1 ? true : false,
            ));
  }

  @override
  Future<bool> delete(Todo todo) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> edit(Todo todo) {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Future<Todo> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }
}
