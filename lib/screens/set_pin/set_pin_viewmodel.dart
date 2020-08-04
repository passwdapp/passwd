import 'package:flutter/foundation.dart';
import 'package:passwd/models/biometrics_result.dart';
import 'package:passwd/router/router.gr.dart';
import 'package:passwd/services/authentication/authentication_service.dart';
import 'package:passwd/services/biometrics/biometrics_service.dart';
import 'package:passwd/services/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class SetPinViewModel extends ChangeNotifier {
  bool _biometrics = false;
  bool get biometrics => _biometrics;

  Future<void> setBiometrics(bool value) async {
    if (value) {
      BiometricsResult result = await locator<BiometricsService>()
          .authenticate("Initialize biometrics");

      if (result == BiometricsResult.AUTHENTICATED) {
        _biometrics = true;
      } else {
        _biometrics = false;
      }
    } else {
      _biometrics = false;
    }

    notifyListeners();
  }

  int _pin;
  int get pin => _pin;

  set pin(int pin) {
    _pin = pin;
    notifyListeners();
    nextEnabled = true;
  }

  bool _nextEnabled = false;
  bool get nextEnabled => _nextEnabled;

  set nextEnabled(bool value) {
    _nextEnabled = value;
    notifyListeners();
  }

  Future<bool> biometricsAvailable() async {
    return await locator<BiometricsService>().biometricsAvailable();
  }

  Future next() async {
    await locator<AuthenticationService>().writePin(_pin);
    locator<NavigationService>().clearStackAndShow(Routes.homeScreen);
  }
}
