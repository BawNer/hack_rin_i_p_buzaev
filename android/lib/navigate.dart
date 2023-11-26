import 'package:centr_invest_app/modules/auth/screen.dart';
import 'package:centr_invest_app/modules/create_order/screen.dart';
import 'package:centr_invest_app/modules/home/screen.dart';
import 'package:centr_invest_app/modules/user/screen.dart';
import 'package:flutter/material.dart';

class Navigate {
  static openScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static openAuthScreen(BuildContext context) {
    openScreen(context, const AuthScreen());
  }

  static openHomeScreen(BuildContext context) {
    openScreen(context, const HomeScreen());
  }

  static openCreateOrderScreen(BuildContext context) {
    openScreen(context, const CreateOrderScreen());
  }

  static openUserScreen(BuildContext context) {
    openScreen(context, const UserScreen());
  }

}