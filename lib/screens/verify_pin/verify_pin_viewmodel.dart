import 'package:flutter/foundation.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../models/biometrics_result.dart';
import '../../router/router.gr.dart';
import '../../services/authentication/authentication_service.dart';
import '../../services/biometrics/biometrics_service.dart';
import '../../services/locator.dart';

class VerifyPinViewModel extends ChangeNotifier {
  VerifyPinViewModel() {
    tryBiometrics();
  }

  int _pin;
  int get pin => _pin;

  set pin(int pin) {
    _pin = pin;
    verifyPin(_pin);
  }

  String _error = "";
  String get error => _error;

  void replace() {
    locator<NavigationService>().clearStackAndShow(Routes.homeScreen);
  }

  Future verifyPin(int pin) async {
    bool valid = await locator<AuthenticationService>().comparePin(pin);

    if (valid) {
      replace();
    } else {
      _error = "Invalid pin entered";
    }

    notifyListeners();
  }

  Future<bool> biometricsAvailable() async {
    if (await locator<AuthenticationService>().allowBiometrics() &&
        await locator<BiometricsService>().biometricsAvailable()) {
      return true;
    } else {
      return false;
    }
  }

  Future tryBiometrics() async {
    if (await biometricsAvailable()) {
      BiometricsResult result = await locator<BiometricsService>()
          .authenticate("To unlock your vault.");

      if (result == BiometricsResult.AUTHENTICATED) {
        replace();
      }
    }
  }
}
