import 'package:biometric_storage/biometric_storage.dart';
import 'package:injectable/injectable.dart';

import '../../models/biometrics_result.dart';
import 'biometrics_service.dart';

/// [BiometricsBiometricStorage] uses "local_auth" to provide a concrete implementation for [BiometricsService]
@LazySingleton(as: BiometricsService)
class BiometricsBiometricStorage implements BiometricsService {
  final storage = 'DUMMY';

  @override
  Future<BiometricsResult> authenticate(String reason) async {
    if (!(await biometricsAvailable())) {
      return BiometricsResult.UNAVAILABLE;
    }

    try {
      await BiometricStorage().getStorage(
        '$storage',
        options: StorageFileInitOptions(
          authenticationRequired: true,
        ),
        androidPromptInfo: AndroidPromptInfo(
          confirmationRequired: true,
          negativeButton: 'Cancel', // TODO: localize
          description: '',
          title: 'Passwd',
        ),
      );
      return BiometricsResult.AUTHENTICATED;
    } catch (e) {
      print(e);
      return BiometricsResult.REJECTED;
    }
  }

  @override
  Future<bool> biometricsAvailable() async {
    final status = await BiometricStorage().canAuthenticate();

    if (status == CanAuthenticateResponse.success) {
      return true;
    }

    return false;
  }
}
