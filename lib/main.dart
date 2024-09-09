import 'package:flutter/material.dart';
import 'package:notes/src/app_db.dart';
import 'package:notes/src/app_shared.dart';

import 'src/app_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppShared.init();
  await AppDB.createDatabase();
  runApp(const AppRoot());
}
