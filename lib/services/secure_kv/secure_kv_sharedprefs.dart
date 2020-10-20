import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'secure_kv.dart';

/// [SecureKVSecureStorage] implements the [SecureKVService] using "shared_preferences"
/// As "flutter_secure_storage" is not avilable on desktop platforms, this implementation is only injected on a desktop environment
@Environment("desktop")
@LazySingleton(as: SecureKVService)
class SecureKVSecureStorage implements SecureKVService {
  SharedPreferences preferences;

  Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<String> getValue(String key) async {
    if (preferences == null) {
      await init();
    }

    return preferences.getString(key);
  }

  @override
  Future putValue(String key, String value) async {
    if (preferences == null) {
      await init();
    }

    return await preferences.setString(key, value);
  }
}
