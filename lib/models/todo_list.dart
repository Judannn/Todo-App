import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:test_app/models/todo.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = <Todo>[
    Todo(name: "Shopping", description: "Pick up groceries"),
    Todo(name: "Paint", description: "Recreate the Mona Lisa"),
    Todo(name: "Dance", description: "I wanna dance with somebody"),
  ];

  //protected copy of list
  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get todoCount => _todos.length;

  void add(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeAll() {
    _todos.clear();
    notifyListeners();
  }

  void remove(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  void update(Todo todo) {
    Todo listTodo = _todos.firstWhere((t) => t.name == todo.name);
    listTodo = todo;
    notifyListeners();
  }
}
