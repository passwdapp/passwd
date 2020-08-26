import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:passwd/constants/colors.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/models/otp.dart';
import 'package:passwd/router/router.gr.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/services/password/password_service.dart';
import 'package:passwd/services/qr/qr_service.dart';
import 'package:passwd/utils/validate.dart';
import 'package:passwd/validators/min_validator.dart';
import 'package:stacked_services/stacked_services.dart';

class AddAccountViewModel extends ChangeNotifier {
  String _name = "";
  String get name => _name;

  set name(String name) {
    _name = name;
    notifyListeners();
  }

  String _username = "";
  String get username => _username;

  set username(String username) {
    _username = username;

    isUsernameValid = validate<bool>(
      MinValidator(
        min: 1,
      ),
      username,
      true,
      false,
    );
  }

  String _password = "";
  String get password => _password;

  set password(String password) {
    _password = password;

    isPasswordValid = validate<bool>(
      MinValidator(
        min: 1,
      ),
      password,
      true,
      false,
    );
  }

  String _notes = "";
  String get notes => _notes;

  set notes(String notes) {
    _notes = notes;
    notifyListeners();
  }

  bool _isUsernameValid = false;
  bool get isUsernameValid => _isUsernameValid;

  set isUsernameValid(bool isUsernameValid) {
    _isUsernameValid = isUsernameValid;
    notifyListeners();
  }

  bool _isPasswordValid = false;
  bool get isPasswordValid => _isPasswordValid;

  set isPasswordValid(bool isPasswordValid) {
    _isPasswordValid = isPasswordValid;
    notifyListeners();
  }

  Otp _otp = Otp();
  Otp get otp => _otp;

  set otp(Otp otp) {
    _otp = otp;
    notifyListeners();
  }

  bool _otpAvailable = false;
  bool get otpAvailable => _otpAvailable;

  set otpAvailable(bool otpAvailable) {
    _otpAvailable = otpAvailable;
    notifyListeners();
  }

  void pop() {
    locator<NavigationService>().back();
  }

  Future generatePassword(void Function(String) setText) async {
    String password = (await locator<NavigationService>()
        .navigateTo(Routes.generatePasswordScreen)) as String;

    if (password.isNotEmpty) {
      _password = password;
      notifyListeners();

      setText(password);
    }
  }

  void popWithData() {
    if (isUsernameValid && isPasswordValid) {
      Entry data = Entry(
        favicon: "",
        name: _name,
        note: _notes,
        password: _password,
        username: _username,
        colorId: Random.secure().nextInt(iconColors.length),
        id: locator<PasswordService>().generateRandomPassword(
          length: 24,
        ),
        tags: [],
      );

      if (otpAvailable) {
        data.otp = otp;
      }

      locator<NavigationService>().back(result: data);
    }
  }

  Future toOtp() async {
    Otp otp =
        await locator<NavigationService>().navigateTo(Routes.addOtpScreen);

    if (otp != null) {
      this.otp = otp;
      otpAvailable = true;
    }
  }

  Future<void> scanOtp(void Function() showError) async {
    try {
      Otp otp = await locator<QRService>().scanQRForOtp();

      this.otp = otp;
      otpAvailable = true;
    } catch (e) {
      showError();
    }
  }
}
