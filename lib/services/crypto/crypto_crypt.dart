import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:injectable/injectable.dart';
import 'package:passwd/services/crypto/crypto_service.dart';

@LazySingleton(as: CryptoService)
class CryptoCrypt implements CryptoService {
  @override
  String sha512(String input) {
    return crypto.sha512.convert(utf8.encode(input)).toString();
  }
}
