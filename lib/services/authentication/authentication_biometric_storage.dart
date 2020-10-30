import 'package:biometric_storage/biometric_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:supercharged/supercharged.dart';

import '../crypto/crypto_service.dart';
import '../locator.dart';
import '../secure_kv/secure_kv.dart';
import 'authentication_service.dart';

/// [AuthenticationBiometricStorage] implements the [AuthenticationService] to provide an implementation for the authentication used in app
@LazySingleton(as: AuthenticationService)
class AuthenticationBiometricStorage implements AuthenticationService {
  final key = 'ENCRYPTION_KEY';
  final biometricsKey = 'ALLOW_BIOMETRICS';
  final appSetupKey = 'APP_SETUP';
  final storageName = 'ENC_KEY_';

  final crypto = locator<CryptoService>();
  final kv = locator<SecureKVService>();

  String encryptionKey;

  Future<BiometricStorageFile> getStorage({bool useBiometrics = false}) async {
    return await BiometricStorage().getStorage(
      '$storageName${useBiometrics ? 'BIOMETRIC' : 'NON_BIOMETRIC'}',
      options: StorageFileInitOptions(
        authenticationRequired: useBiometrics,
      ),
      androidPromptInfo: AndroidPromptInfo(
        confirmationRequired: true,
        negativeButton: 'Cancel', // TODO: localize
        description: '',
        title: 'Passwd',
      ),
    );
  }

  @override
  Future<bool> comparePin(int pin) async {
    try {
      if (pin == null) {
        final storage = await getStorage(useBiometrics: true);
        final storedKey = await storage.read();
        if (storedKey == null || storage == null) {
          return false;
        }

        encryptionKey = storedKey;
        return true;
      } else {
        final storage = await getStorage(useBiometrics: false);
        final storedKey = await storage.read();
        final s512 = crypto.sha512(pin.toString());

        if (storedKey == s512) {
          encryptionKey = storedKey;
          return true;
        }

        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  // async to retain compatibility
  @override
  Future<String> readEncryptionKey() async {
    return encryptionKey;
  }

  @override
  Future writeBiometrics(bool allow) async {
    await kv.putValue(biometricsKey, allow ? '1' : '0');
  }

  @override
  Future<bool> allowBiometrics() async {
    return (await kv.getValue(biometricsKey)).toInt() == 1 ? true : false;
  }

  @override
  Future writePin(int pin, bool biometrics) async {
    final encryptionKey = crypto.sha512(pin.toString());

    final nonBiometricStorage = await getStorage(useBiometrics: false);
    await nonBiometricStorage.write(encryptionKey);

    if (biometrics) {
      final biometricStorage = await getStorage(useBiometrics: true);
      await biometricStorage.write(encryptionKey);
    }

    await kv.putValue(appSetupKey, '1');
    this.encryptionKey = encryptionKey;
  }

  @override
  Future<bool> isAppSetup() async {
    try {
      return (await kv.getValue(appSetupKey)) != null;
    } catch (e) {
      return false;
    }
  }
}
