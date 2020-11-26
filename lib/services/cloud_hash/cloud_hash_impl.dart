import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:cryptography/cryptography.dart';

import 'cloud_hash_service.dart';

class CloudHashImpl implements CloudHashService {
  @override
  Future<Uint8List> deriveSyncEncryptionPassword(
    String username,
    String password,
  ) async {
    final usernameBytes = username.codeUnits;
    final passwordBytes = password.codeUnits;

    final hmac = crypto.Hmac(crypto.sha512, usernameBytes);
    var digest = hmac.convert(passwordBytes);

    for (var i = 0; i < 256; i++) {
      digest = hmac.convert(digest.bytes);
    }

    final hkdf = Hkdf(Hmac(sha512));
    final input = SecretKey(digest.toString().codeUnits);
    final output = await hkdf.deriveKey(input, outputLength: 32);

    return (await output.extract());
  }

  @override
  String deriveSyncPassword(String username, String password) {
    final usernameBytes = username.codeUnits;
    final passwordBytes = password.codeUnits;

    final hmac = crypto.Hmac(crypto.sha512, usernameBytes);
    var digest = hmac.convert(passwordBytes);

    for (var i = 0; i < 1024; i++) {
      digest = hmac.convert(digest.bytes);
    }

    return digest.toString();
  }
}
