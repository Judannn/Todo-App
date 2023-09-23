import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/services/datasource.dart';

class TodoList extends ChangeNotifier {
  late List<Todo> _todos = <Todo>[];

  //protected copy of list
  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int completeTodo = 0;
  int incompleteTodo = 0;

  TodoList() {
    browse(ListFilter.all);
  }

  Future<void> browse(ListFilter filter) async {
    List<Todo> filteredTodos = await GetIt.I<DataSource>().browse();
    // Find counts for complete and incomplete
    completeTodo = 0;
    incompleteTodo = 0;
    for (Todo todo in filteredTodos) {
      todo.completed ? completeTodo++ : incompleteTodo++;
    }

    // Filter list based on filter
    switch (filter) {
      case ListFilter.complete:
        _todos = filteredTodos.where((todo) => todo.completed).toList();
      case ListFilter.incomplete:
        _todos = filteredTodos.where((todo) => !todo.completed).toList();
      case ListFilter.all:
        _todos = filteredTodos;
    }
    notifyListeners();
  }

  Future<void> add(Map<String, dynamic> todo) async {
    await GetIt.I<DataSource>().add(todo);
    await browse(ListFilter.all);
    notifyListeners();
  }

  Future<void> edit(Map<String, dynamic> todo) async {
    await GetIt.I<DataSource>().edit(todo);
    await browse(ListFilter.all);
    notifyListeners();
  }

  Future<void> delete(Map<String, dynamic> todo) async {
    await GetIt.I<DataSource>().delete(todo);
    await browse(ListFilter.all);
    notifyListeners();
  }
}
