import 'package:barcode_scan/barcode_scan.dart';
import 'package:injectable/injectable.dart';
import 'package:supercharged/supercharged.dart';

import '../../models/otp.dart';
import 'qr_service.dart';

/// [QRFlutterBarcodeScanner] uses the "barcode_scan" package to implement [QRService]
@LazySingleton(as: QRService)
class QRFlutterBarcodeScanner implements QRService {
  String errorText = "The QR code does not correspond to a OTP";

  @override
  Future<Otp> scanQRForOtp() async {
    ScanResult scanResult = await BarcodeScanner.scan();

    if (scanResult.rawContent.isNotEmpty) {
      Uri uri = Uri.parse(scanResult.rawContent);

      if (uri.scheme == "otpauth" &&
          uri.host == "totp" &&
          uri.queryParameters["secret"].isNotEmpty) {
        return Otp(
          account: "ih", // ih stands for inherit (from parent)
          algorithm: uri.queryParameters["algorithm"] ?? "SHA1",
          digits: uri.queryParameters["digits"].toInt() ?? 6,
          issuer: "ih",
          secret: uri.queryParameters["secret"],
          timeout: uri.queryParameters["period"].toInt() ?? 30,
          type: "t", // T is TOTP
        );
      } else {
        throw errorText;
      }
    } else {
      throw errorText;
    }
  }
}
