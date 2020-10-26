import 'dart:io';

import 'package:flutter/services.dart';
// import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

import '../../models/biometrics_result.dart';
import 'biometrics_service.dart';

/// [BiometricsLocalAuth] uses "local_auth" to provide a concrete implementation for [BiometricsService]
/// This implementation, due to being insecure, is no longer injected. [BiometricsBiometricStorage] is used instead
class BiometricsLocalAuth implements BiometricsService {
  final LocalAuthentication authentication = LocalAuthentication();

  @override
  Future<BiometricsResult> authenticate(String reason) async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      return BiometricsResult.UNAVAILABLE;
    }

    try {
      final authenticated = await authentication.authenticateWithBiometrics(
        localizedReason: reason,
        stickyAuth: true,
      );

      if (authenticated) {
        return BiometricsResult.AUTHENTICATED;
      } else {
        return BiometricsResult.REJECTED;
      }
    } catch (e) {
      print(e);
      return BiometricsResult.UNAVAILABLE;
    }
  }

  @override
  Future<bool> biometricsAvailable() async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      return false;
    }

    try {
      return await authentication.canCheckBiometrics;
    } on PlatformException catch (_) {
      return false;
    }
  }
}
