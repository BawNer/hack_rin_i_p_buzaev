import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String accessToken;

  @HiveField(1)
  final int expiresAt;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String lastname;

  @HiveField(4)
  final String surname;

  @HiveField(5)
  final String login;


  static const collectionDB = 'User';

  const UserModel({
    required this.accessToken,
    required this.expiresAt,
    required this.login,
    required this.lastname,
    required this.name,
    required this.surname
  });
}