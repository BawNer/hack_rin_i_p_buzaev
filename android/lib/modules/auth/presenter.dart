import 'package:centr_invest_app/injector.dart';
import 'package:centr_invest_app/models/user.dart';
import 'package:centr_invest_app/modules/auth/contract.dart';

class AuthPresenter {
  late AuthContract _view;

  AuthPresenter(AuthContract view) {
    _view = view;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(String login, String password) async {
    _isLoading = true;
    _view.render();
    try {
      final user = await Injector().user.login(login, password);
      await Injector().user.save(user);
      _isLoading = false;
      _view.render();
      return true;
    } catch(e) {
      _isLoading = false;
      _view.render();
      return Future.error(e);
    }
  }
}