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

  Future<void> initialise() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'todo_data.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY, name TEXT, description TEXT, completed INTEGER, dateCreated TEXT )');
      },
    );
  }

  // if (mapData['completed'] is int) {
  //   mapData['completed'] = mapData['completed'] == 0 ? false : true;
  // }

  // // Check
  // if (mapData['id'] is int) {
  //   mapData['id'] = mapData['id'].toString();
  // }

  @override
  Future<List<Todo>> browse() async {
    await init;
    List<Map<String, dynamic>> maps = await database.query('todos');

    return List.generate(maps.length, (index) {
      // Prep
      String id;
      bool completed;
      Map<String, dynamic> map = maps[index];
      id = map['id'].toString();
      completed = map['completed'] == 1 ? true : false;

      // Create Todo
      return Todo(
          id: id,
          name: map['name'],
          description: map['description'],
          dateCreated: map['dateCreated'],
          completed: completed);
    });
  }

  @override
  Future<void> edit(Todo todo) async {
    await init;
    Map<String, dynamic> todoMap = todo.toMap();
    todoMap['completed'] = todo.completed ? 1 : 0;
    await database.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  @override
  Future<void> add(Todo todo) async {
    await init;
    Map<String, dynamic> todoMap = todo.toMap();
    todoMap.remove('id');
    await database.insert('todos', todoMap);
  }

  @override
  Future<void> delete(Todo todo) async {
    await init;
    await database.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }
}
