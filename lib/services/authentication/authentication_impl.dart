// import 'package:injectable/injectable.dart';
import 'package:supercharged/supercharged.dart';

import '../crypto/crypto_service.dart';
import '../locator.dart';
import '../secure_kv/secure_kv.dart';
import 'authentication_service.dart';

/// [AuthenticationImpl] implements the [AuthenticationService] to provide an implementation for the authentication used in app
class AuthenticationImpl implements AuthenticationService {
  final String key = 'ENCRYPTION_KEY';
  final String biometricsKey = 'ALLOW_BIOMETRICS';

  final CryptoService crypto = locator<CryptoService>();
  final SecureKVService kv = locator<SecureKVService>();

  @override
  Future<bool> comparePin(int pin) async {
    final s256 = crypto.sha512(pin.toString());
    final encryptionKey = await kv.getValue(key);

    return s256 == encryptionKey;
  }

  @override
  Future<String> readEncryptionKey() async {
    return await kv.getValue(key);
  }

  @override
  Future writePin(int pin, bool _) async {
    final encryptionKey = crypto.sha512(pin.toString());
    await kv.putValue(key, encryptionKey);
  }

  @override
  Future<bool> allowBiometrics() async {
    return (await kv.getValue(biometricsKey)).toInt() == 1 ? true : false;
  }

  @override
  Future writeBiometrics(bool allow) async {
    await kv.putValue(biometricsKey, allow ? '1' : '0');
  }

  @override
  Future<bool> isAppSetup() {
    // TODO: implement isAppSetup
    throw UnimplementedError();
  }
}
