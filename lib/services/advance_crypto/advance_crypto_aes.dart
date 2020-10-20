import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:encrypt/encrypt.dart';
import 'package:injectable/injectable.dart';

import '../crypto/crypto_service.dart';
import '../locator.dart';
import 'advance_crypto_service.dart';

/// [AdvanceCryptAes] implements the [AdvanceCryptService] to provide a concrete implementation of the same.
/// It uses the dart libraries "encrypt" and "cryptography" to derive a key and encrypt an object with it
@LazySingleton(as: AdvanceCryptoService)
class AdvanceCryptoAes implements AdvanceCryptoService {
  final CryptoService cryptoService = locator<CryptoService>();

  @override
  Future<String> encryptText(
    String plainText,
    String password,
  ) async {
    Key key = Key(await deriveKey(password));
    Encrypter encrypter = Encrypter(AES(key));
    IV iv = IV.fromSecureRandom(16);
    Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);

    return "${encrypted.base64}|${iv.base64}";
  }

  @override
  Future<Uint8List> encryptBinary(
    Uint8List data,
    String password,
  ) async {
    Key key = Key(await deriveKey(password));
    Encrypter encrypter = Encrypter(AES(key));
    IV iv = IV.fromSecureRandom(16);
    Encrypted encrypted = encrypter.encryptBytes(data, iv: iv);

    return Uint8List.fromList([...encrypted.bytes, ...iv.bytes]);
  }

  @override
  Future<String> decryptText(
    String cipherText,
    String password,
  ) async {
    Key key = Key(await deriveKey(password));
    Encrypter encrypter = Encrypter(AES(key));

    try {
      List<String> encrypted = cipherText.split("|");

      String decrypted = encrypter.decrypt(
        Encrypted.from64(encrypted[0]),
        iv: IV.fromBase64(encrypted[1]),
      );

      return decrypted;
    } catch (e) {
      throw Exception("There was an error decrypting the inputs");
    }
  }

  @override
  Future<Uint8List> decryptBinary(
    Uint8List data,
    String password,
  ) async {
    Key key = Key(await deriveKey(password));
    Encrypter encrypter = Encrypter(AES(key));

    try {
      List<int> decrypted = encrypter.decryptBytes(
        Encrypted(data.sublist(0, data.length - 16)),
        iv: IV(data.sublist(data.length - 16, data.length)),
      );

      return Uint8List.fromList(decrypted);
    } catch (e) {
      throw Exception("There was an error decrypting the inputs");
    }
  }

  @override
  Future<Uint8List> deriveKey(
    String password,
  ) async {
    final hkdf = Hkdf(Hmac(sha512));
    final input = SecretKey(
      utf8.encode(
        cryptoService.hmac(utf8.encode(password)),
      ),
    );
    final output = await hkdf.deriveKey(input, outputLength: 32);

    return await output.extract();
  }
}
