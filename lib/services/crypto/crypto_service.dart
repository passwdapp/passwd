import 'dart:typed_data';

abstract class CryptoService {
  String sha512(String input);
  String hmac(Uint8List input);
}
