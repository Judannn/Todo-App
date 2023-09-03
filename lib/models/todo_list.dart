import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/services/todo_datasource.dart';

class TodoList extends ChangeNotifier {
  late List<Todo> _todos = <Todo>[];

  //protected copy of list
  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get todoCount => _todos.length;

  Future<void> refresh() async {
    _todos = await GetIt.I<TodoDataSource>().browse();
    notifyListeners();
  }

  Future<void> add(Todo todo) async {
    await GetIt.I<TodoDataSource>().add(todo);
    notifyListeners();
  }

  Future<void> edit(Todo todo) async {
    await GetIt.I<TodoDataSource>().edit(todo);
    notifyListeners();
  }

  Future<void> check(Todo todo) async {
    await GetIt.I<TodoDataSource>().edit(todo);
    notifyListeners();
  }
}
