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

  @override
  Future<List<Todo>> browse() async {
    await init; //wait for init completion before attempting to fetch data

    List<Map<String, dynamic>> maps = await database.query('todos');
    return List.generate(
        maps.length,
        (index) => Todo(
              internalID: maps[index]['id'].toString(),
              name: maps[index]['name'],
              description: maps[index]['description'],
              completed: maps[index]['completed'] == 1 ? true : false,
              dateCreated: maps[index]['dateCreated'],
            ));
  }

  @override
  Future<Todo> read(String id) async {
    await init;
    List<Map<String, dynamic>> maps = await database.query(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return Todo(name: "", description: "", dateCreated: "");
    }

    Map<String, dynamic> todoMap = maps.first;
    return Todo(
      internalID: todoMap['id'],
      name: todoMap['name'],
      description: todoMap['description'],
      completed: todoMap['completed'] == 1,
      dateCreated: todoMap['dateCreated'],
    );
  }

  @override
  Future<bool> edit(Map<String, dynamic> todoMap) async {
    await init;
    Todo todo = Todo(
        internalID: todoMap['id'],
        name: todoMap['name'],
        description: todoMap['description'],
        completed: todoMap['completed'],
        dateCreated: todoMap['dateCreated']);
    final int rowsUpdated = await database.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
    return rowsUpdated > 0;
  }

  @override
  Future<bool> add(Map<String, dynamic> todoMap) async {
    await init;
    todoMap.remove('id');
    final int id = await database.insert('todos', todoMap);
    return id > 0;
  }

  @override
  Future<bool> delete(Map<String, dynamic> todoMap) async {
    await init;
    final int rowsDeleted = await database.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [todoMap['id']],
    );
    return rowsDeleted > 0;
  }
}
