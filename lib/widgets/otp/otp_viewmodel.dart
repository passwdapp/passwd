import 'dart:async';

import 'package:dart_otp/dart_otp.dart';
import 'package:passwd/models/otp.dart';
import 'package:stacked/stacked.dart';

class OtpWidgetViewModel extends BaseViewModel {
  final Otp otp;

  String _currentOtp = "";
  String get currentOtp => _currentOtp;

  set currentOtp(String currentOtp) {
    _currentOtp = currentOtp;
    notifyListeners();
  }

  double _percentage = 0.0;
  double get percentage => _percentage;

  set percentage(double percentage) {
    _percentage = percentage;
    notifyListeners();
  }

  Timer timer;

  OtpWidgetViewModel({this.otp}) {
    assert(otp != null);

    timer = Timer.periodic(
      const Duration(
        milliseconds: 100,
      ),
      (_) {
        genOtp();
      },
    );
    genOtp();
  }

  void genOtp() {
    TOTP totp = TOTP(
      secret: otp.secret,
      algorithm: OTPAlgorithm.SHA1,
      digits: otp.digits,
      interval: otp.timeout,
    );

    currentOtp = totp.now();

    percentage =
        (otp.timeout - (DateTime.now().second % otp.timeout)) / otp.timeout;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
