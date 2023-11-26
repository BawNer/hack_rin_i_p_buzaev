import 'package:centr_invest_app/models/user.dart';
import 'package:hive/hive.dart';

class UserRepository {
  Future<Box<UserModel>> get _container => Hive.openBox(UserModel.collectionDB);

  Future<bool> get isValid async {
    final user = (await _container).get('user', defaultValue: null);

    if (user == null) return false;

    final hasToken = user.accessToken.isNotEmpty;
    if (hasToken) {
      return (DateTime.now()).millisecondsSinceEpoch < user.expiresAt;
    }

    return false;
  }

  Future<void> save(UserModel user) async {
    (await _container).put('user', user);
  }

  Future<UserModel?> get user async {
    return (await _container).get('user');
  }

  Future<UserModel> login(String login, String password) async {
    Uri auth = Uri(
      scheme: const String.fromEnvironment("SCHEME", defaultValue: 'http'),
      host: const String.fromEnvironment("AUTH", defaultValue: 'localhost'),
      path: "/login"
    );

    // make request here

    final DateTime date = DateTime.now();

    return UserModel(
        accessToken: 'accessToken',
        expiresAt: DateTime(date.year, date.month, date.day + 1, 23, 59, 59).millisecondsSinceEpoch,
        login: login,
        lastname: 'lastname',
        name: 'name',
        surname: 'surname'
    );
  }

  Future<void> logout() async {
    (await _container).delete('user');
  }
}