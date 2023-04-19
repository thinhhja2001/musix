import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:musix/domain_auth/utils/model/auth_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../utils.dart';

class HiveUtils {
  static Future<void> initHive() async {
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }

    Hive.registerAdapter<AuthStorage>(AuthStorageAdapter());
  }

  static FutureOr<void> openBox() async {
    await Hive.openBox<AuthStorage>(HiveBoxConstant.authStorageBox);
  }

  static AuthStorage? readAuthStorage() {
    final authBox = Hive.box<AuthStorage>(HiveBoxConstant.authStorageBox);
    final authStorage = authBox.get(HiveBoxConstant.authStorageData);

    if (authStorage == null) {
      return null;
    } else {
      return authStorage;
    }
  }

  static Future<AuthStorage> createAuthStorage(
      String token, String username) async {
    final authBox = Hive.box<AuthStorage>(HiveBoxConstant.authStorageBox);
    await authBox.put(HiveBoxConstant.authStorageData,
        AuthStorage(token: token, username: username));
    return authBox.get(HiveBoxConstant.authStorageData)!;
  }
}
