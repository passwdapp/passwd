import 'dart:io';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:passwd/models/biometrics_result.dart';
import 'package:passwd/services/biometrics/biometrics_service.dart';

@LazySingleton(as: BiometricsService)
class BiometricsLocalAuth implements BiometricsService {
  final LocalAuthentication authentication = LocalAuthentication();

  @override
  Future<BiometricsResult> authenticate(String reason) async {
    if (!Platform.isAndroid || !Platform.isIOS) {
      return BiometricsResult.UNAVAILABLE;
    }

    try {
      bool authenticated = await authentication.authenticateWithBiometrics(
        localizedReason: reason,
        stickyAuth: true,
      );

      if (authenticated) {
        return BiometricsResult.AUTHENTICATED;
      } else {
        return BiometricsResult.REJECTED;
      }
    } catch (_) {
      return BiometricsResult.UNAVAILABLE;
    }
  }

  @override
  Future<bool> biometricsAvailable() async {
    if (!Platform.isAndroid || !Platform.isIOS) {
      return false;
    }

    try {
      return await authentication.canCheckBiometrics;
    } on PlatformException catch (_) {
      return false;
    }
  }
}
