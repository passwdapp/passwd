import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:injectable/injectable.dart';
import 'package:passwd/services/crypto/crypto_service.dart';

@LazySingleton(as: CryptoService)
class CryptoCrypt implements CryptoService {
  /*
    WARNING
    DO *NOT* CHANGE THIS KEY, ELSE THE DATABASES AND SYNCED BACKUPS WILL *NOT* BE DECRYPTABLE 
    THE KEY IS A CONSTANT, ONLY USED TO PREVENT RAINBOW TABLE PASSWORD ATTACKS
    THE KEY IS PUBLIC, BUT DO *NOT* REUSE THIS ACCROSS OTHER APPLICATIONS EXCEPT PASSWD
    I REPEAT, DO *NOT* CHANGE THIS KEY
    WARNING
  */
  final Uint8List hmacKey = utf8.encode(
    "3MPJwJw9UvN8GQEUi4v8LBJCkmLa1a0K3RvskDVhjDvdcp2hiI4D7sf4KIhI8RAT",
  );

  @override
  String sha512(String input) {
    return crypto.sha512.convert(utf8.encode(input)).toString();
  }

  @override
  String hmac(Uint8List input) {
    crypto.Hmac hmac = crypto.Hmac(crypto.sha512, hmacKey);
    return hmac.convert(input).toString();
  }
}
