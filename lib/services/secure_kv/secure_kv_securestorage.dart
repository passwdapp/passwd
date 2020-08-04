import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:passwd/services/secure_kv/secure_kv.dart';

@LazySingleton(as: SecureKVService)
class SecureKVSecureStorage implements SecureKVService {
  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  Future<String> getValue(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future putValue(String key, String value) async {
    return await storage.write(key: key, value: value);
  }
}
