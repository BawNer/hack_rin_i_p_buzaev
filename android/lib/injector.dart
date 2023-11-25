import 'package:centr_invest_app/repository/user.dart';

class Injector {
  Injector._();

  static final Injector _instance = Injector._();

  factory Injector() => _instance;

  UserRepository user = UserRepository();


  final DateTime _date = DateTime.now();

}