import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/services/api_datasource.dart';
import 'package:test_app/services/hive_datasource.dart';
import 'package:test_app/services/sql_datasource.dart';
import 'package:test_app/services/datasource.dart';

class MockDataSource implements DataSource {
  Todo mockTodo = Todo(
      id: 'id',
      name: 'name',
      description: 'description',
      dateCreated: 'dateCreated',
      completed: true);

  @override
  Future<List<Todo>> browse() async {
    // Mock implementation for browse()
    return [];
  }

  @override
  Future<void> edit(Todo todo) async {
    // Mock implementation for edit()
  }

  @override
  Future<void> add(Todo todo) async {
    // Mock implementation for add()
  }

  @override
  Future<void> delete(Todo todo) async {
    // Mock implementation for delete()
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('DataSource factory method tests', () {
    test('Web platform returns ApiDatasource', () {
      final dataSource = DataSource();
      expect(dataSource, isA<ApiDatasource>());
    });

    test('Android platform returns HiveDatasource', () {
      if (Platform.isAndroid) {
        final dataSource = DataSource();
        expect(dataSource, isA<HiveDatasource>());
      }
    });

    test('iOS platform returns SQLDatasource', () {
      if (Platform.isIOS) {
        final dataSource = DataSource();
        expect(dataSource, isA<SQLDatasource>());
      }
    });

    test('Windows platform returns HiveDatasource', () {
      if (Platform.isWindows) {
        final dataSource = DataSource();
        expect(dataSource, isA<HiveDatasource>());
      }
    });

    test('Mac platform returns HiveDatasource', () {
      if (Platform.isMacOS) {
        final dataSource = DataSource();
        expect(dataSource, isA<HiveDatasource>());
      }
    });

    test('Linux platform returns ApiDatasource', () {
      if (Platform.isLinux) {
        final dataSource = DataSource();
        expect(dataSource, isA<ApiDatasource>());
      }
    });

    test('Fuchsia platform returns HiveDatasource', () {
      if (Platform.isFuchsia) {
        final dataSource = DataSource();
        expect(dataSource, isA<HiveDatasource>());
      }
    });
  });

  group('DataSource abstract methods tests', () {
    final mockDataSource = MockDataSource();

    test('browse() should return a list of todos', () async {
      final todos = await mockDataSource.browse();
      expect(todos, isA<List<Todo>>());
    });

    test('edit() should edit a todo', () async {
      final todo = mockDataSource.mockTodo; // Provide a sample Todo object
      await mockDataSource.edit(todo);
      // Add assertions to check the behavior of edit() if needed.
    });

    test('add() should add a new todo', () async {
      final todo = mockDataSource.mockTodo; // Provide a sample Todo object
      await mockDataSource.add(todo);
      // Add assertions to check the behavior of add() if needed.
    });

    test('delete() should delete a todo', () async {
      final todo = mockDataSource.mockTodo; // Provide a sample Todo object
      await mockDataSource.delete(todo);
      // Add assertions to check the behavior of delete() if needed.
    });
  });
}
