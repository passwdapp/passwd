import 'package:passwd/models/otp.dart';

abstract class QRService {
  Future<Otp> scanQRForOtp();
}
