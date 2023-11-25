import 'package:centr_invest_app/models/user.dart';
import 'package:centr_invest_app/modules/home/contract.dart';

import '../../injector.dart';

class HomePresenter {
  late HomeContract _view;

  HomePresenter(HomeContract view) {
    _view = view;
  }

  UserModel? user;

  Future<void> getUser() async {
    user = await Injector().user.user;
  }
}