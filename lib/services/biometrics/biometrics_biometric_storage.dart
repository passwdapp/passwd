import 'package:biometric_storage/biometric_storage.dart';
import 'package:injectable/injectable.dart';

import '../../models/biometrics_result.dart';
import 'biometrics_service.dart';

@LazySingleton(as: BiometricsService)
class BiometricsBiometricStorage implements BiometricsService {
  @override
  Future<BiometricsResult> authenticate(String reason) async {
    throw UnimplementedError();
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
