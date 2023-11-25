import 'package:centr_invest_app/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initDatabase() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());
}