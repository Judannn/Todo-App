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
    await init;
    List<Todo> todos = <Todo>[];
    DataSnapshot snapshot = await database.ref('todos').get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> snapshotValue = snapshot.value as Map;
      if (snapshotValue.isNotEmpty) {
        snapshotValue.forEach((key, map) {
          map['id'] = key;
          map['completed'] = map['completed'] == 1 ? true : false;
          todos.add(Todo.fromMap(map));
        });
      }
    }
    return todos;
  }

  @override
  Future<void> edit(Todo todo) async {
    await init;
    // Get a reference to the specific todo by its ID
    var ref = database.ref('todos').child(todo.id);
    // Prep map
    Map<String, dynamic> todoMap = todo.toMap();
    todoMap['completed'] = todoMap['completed'] ? 1 : 0;
    todoMap.remove('dateCreated');
    // Update the todo with the new data
    await ref.set(todoMap);
  }

  @override
  Future<void> add(Todo todo) async {
    await init;
    // Get a reference to the specific todo by its ID
    var ref = database.ref('todos').push();
    // Prep map
    Map<String, dynamic> todoMap = todo.toMap();
    todoMap['id'] = ref.key;
    todoMap['completed'] = false;
    todoMap.remove('dateCreated');
    // Add the todo
    await ref.set(todoMap);
  }

  @override
  Future<void> delete(Todo todo) async {
    await init;
    // Get a reference to the specific todo by its ID
    var ref = database.ref('todos').child(todo.id);
    // Delete the todo
    await ref.remove();
  }
}
