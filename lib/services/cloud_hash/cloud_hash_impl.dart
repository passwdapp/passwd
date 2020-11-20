import 'package:crypto/crypto.dart';
import 'package:passwd/services/cloud_hash/cloud_hash_service.dart';

class CloudHashImpl implements CloudHashService {
  @override
  String deriveSyncEncryptionPassword(String username, String password) {
    final usernameBytes = username.codeUnits;
    final passwordBytes = password.codeUnits;

    final hmac = Hmac(sha512, usernameBytes);
    var digest = hmac.convert(passwordBytes);

    for (var i = 0; i < 1024; i++) {
      digest = hmac.convert(digest.bytes);
    }

    return digest.toString();
  }

  @override
  String deriveSyncPassword(String username, String password) {
    final usernameBytes = username.codeUnits;
    final passwordBytes = password.codeUnits;

    final hmac = Hmac(sha512, usernameBytes);
    var digest = hmac.convert(passwordBytes);

    for (var i = 0; i < 512; i++) {
      digest = hmac.convert(digest.bytes);
    }

    return digest.toString();
  }
}
