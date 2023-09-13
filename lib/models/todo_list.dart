import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/services/hive_datasource.dart';
import 'package:test_app/services/datasource.dart';

class TodoList extends ChangeNotifier {
  late List<Todo> _todos = <Todo>[];

  //protected copy of list
  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int completeTodo = 0;
  int incompleteTodo = 0;

  Future<void> browse(ListFilter filter) async {
    _todos = await GetIt.I<DataSource>().browse(filter);
    notifyListeners();
  }

  Future<void> add(Todo todo) async {
    await GetIt.I<DataSource>().add(todo);
    await browse(ListFilter.all);
    notifyListeners();
  }

  Future<void> edit(Todo todo) async {
    await GetIt.I<DataSource>().edit(todo);
    notifyListeners();
  }
}
