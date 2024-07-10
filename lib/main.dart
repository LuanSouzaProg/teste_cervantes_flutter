import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'app/shared/helpers/data_base_helper.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbHelper = DatabaseHelper();
  await dbHelper.initDatabase();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(1200, 600));
  }

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
