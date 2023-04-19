import 'package:hive/hive.dart';

part 'auth_storage.g.dart';

@HiveType(typeId: 0)
class AuthStorage with HiveObjectMixin {
  @HiveField(0)
  String _token = "";
  String get token => _token;
  set token(String value) {
    _token = value;
    save();
  }

  @HiveField(1)
  String _username = "";
  String get username => _username;
  set username(String value) {
    _username = value;
    save();
  }

  AuthStorage({
    String token = "",
    String username = "",
  }) {
    _token = token;
    _username = username;
    if (token != "" || username != "") {
      save();
    }
  }
}
