import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/services/api_datasource.dart';
import 'package:test_app/services/hive_datasource.dart';
import 'package:test_app/services/sql_datasource.dart';

enum ListFilter { complete, incomplete, all }

//Interface for all
abstract class DataSource {
  Future<List<Todo>> browse();
  Future<void> edit(Todo todo);
  Future<void> add(Todo todo);
  Future<void> delete(Todo todo);

  factory DataSource() {
    //Check what platform and adjust datasource accordingly
    if (kIsWeb) {
      return ApiDatasource();
    } else if (Platform.isAndroid) {
      return HiveDatasource();
    } else if (Platform.isIOS) {
      return SQLDatasource();
    } else if (Platform.isFuchsia) {
      return HiveDatasource();
    } else if (Platform.isLinux) {
      return ApiDatasource();
    } else if (Platform.isWindows) {
      return HiveDatasource();
    } else if (Platform.isMacOS) {
      return HiveDatasource();
    } else {
      return HiveDatasource();
    }
  }
}
