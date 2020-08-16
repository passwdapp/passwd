import 'package:flutter/foundation.dart';
import 'package:passwd/models/otp.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/utils/validate.dart';
import 'package:passwd/validators/otp_secret_validator.dart';
import 'package:stacked_services/stacked_services.dart';

class AddOtpViewModel extends ChangeNotifier {
  String _secret = "";
  String get secret => _secret;

  set secret(String secret) {
    _secret = secret.toUpperCase();

    isSecretValid =
        validate<bool>(OtpSecretValidator(), secret.toUpperCase(), true, false);
  }

  int _digits = 6;
  int get digits => _digits;

  set digits(int digits) {
    _digits = digits;

    if (digits >= 6 && digits <= 8 && digits != null) {
      isDigitsValid = true;
    } else {
      isDigitsValid = false;
    }
  }

  int _period = 30;
  int get period => _period;

  set period(int period) {
    _period = period;

    if (period == 30 || period == 60) {
      isPeriodValid = true;
    } else {
      isPeriodValid = false;
    }
  }

  bool _isSecretValid = false;
  bool get isSecretValid => _isSecretValid;

  set isSecretValid(bool isSecretValid) {
    _isSecretValid = isSecretValid;
    notifyListeners();
  }

  bool _isDigitsValid = true;
  bool get isDigitsValid => _isDigitsValid;

  set isDigitsValid(bool isDigitsValid) {
    _isDigitsValid = isDigitsValid;
    notifyListeners();
  }

  bool _isPeriodValid = true;
  bool get isPeriodValid => _isPeriodValid;

  set isPeriodValid(bool isPeriodValid) {
    _isPeriodValid = isPeriodValid;
    notifyListeners();
  }

  void pop() {
    locator<NavigationService>().back();
  }

  void popWithData() {
    Otp otp = Otp(
      account: "ih", // ih stands for inherit (from parent)
      algorithm: "1", // 1 is SHA1
      digits: _digits,
      issuer: "ih",
      secret: _secret,
      timeout: _period,
      type: "t", // T is TOTP
    );

    locator<NavigationService>().back(
      result: otp,
    );
  }
}
