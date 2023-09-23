import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/firebase_options.dart';
import 'package:test_app/services/datasource.dart';

class ApiDatasource implements DataSource {
  late FirebaseDatabase database;
  late Future init;

  ApiDatasource() {
    init = initialise();
  }

  Future<void> initialise() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    database = FirebaseDatabase.instance;
  }

  @override
  Future<List<Todo>> browse() async {
    DataSnapshot snapshot = await database.ref().child('todos').get();

    List<Todo> todos = <Todo>[];
    if (snapshot.exists) {
      Map<dynamic, dynamic> snapshotValue = snapshot.value as Map;
      if (snapshotValue.isNotEmpty) {
        snapshotValue.forEach((key, value) {
          value['id'] = key;
          todos.add(Todo.fromMap(value));
        });
      }
    }
    return todos;
  }

  @override
  Future<Todo> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> edit(Map<String, dynamic> todoMap) {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Future<bool> add(Map<String, dynamic> map) async {
    map['completed'] = false;
    var ref = database.ref('todos').push();
    map['id'] = ref.key;
    await ref.set(map);
    return true;
  }

  @override
  Future<bool> delete(Map<String, dynamic> todoMap) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  // @override
  // Future<bool> add(Todo todo) async {

  // }

  // @override
  // Future<List<Todo>> browse(ListFilter filter) async {
  //   DataSnapshot snapshot = await database.ref().child('todos').get();

  //   List<Todo> todos = <Todo>[];
  //   if(snapshot.exists){
  //     Map<dynamic, dynamic> snapshotValue = snapshot.value as Map;
  //     if(snapshotValue.isNotEmpty){

  //       snapshotValue.forEach((key,value) {
  //         value['id'] = key;
  //         todos.add(Todo.fromMap(value));
  //       });
  //     }
  //   }
  // }

  // @override
  // Future<bool> delete(Todo todo) async {
  //   await init;
  //   final int rowsDeleted = await database.delete(
  //     'todos',
  //     where: 'id = ?',
  //     whereArgs: [todo.id],
  //   );
  //   return rowsDeleted > 0;
  // }

  // @override
  // Future<bool> edit(Todo todo) async {
  //   await init;
  //   final int rowsUpdated = await database.update(
  //     'todos',
  //     todo.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [todo.id],
  //   );
  //   return rowsUpdated > 0;
  // }

  // @override
  // Future<Todo> read(String id) async {
  //   await init;
  //   List<Map<String, dynamic>> maps = await database.query(
  //     'todos',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );

  //   if (maps.isEmpty) {
  //     return Todo(name: "", description: "", dateCreated: "");
  //   }

  //   Map<String, dynamic> todoMap = maps.first;
  //   return Todo(
  //     internalID: todoMap['id'],
  //     name: todoMap['name'],
  //     description: todoMap['description'],
  //     completed: todoMap['completed'] == 1,
  //     dateCreated: todoMap['dateCreated'],
  //   );
  // }
}
