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
  Future<Todo> read(String id);
  Future<bool> edit(Map<String, dynamic> todo);
  Future<bool> add(Map<String, dynamic> todo);
  Future<bool> delete(Map<String, dynamic> todo);

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
