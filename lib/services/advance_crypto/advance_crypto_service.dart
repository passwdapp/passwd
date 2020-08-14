import 'dart:typed_data';

abstract class AdvanceCryptoService {
  Future<String> encryptText(
    String plainText,
    String password,
  );
  Future<Uint8List> encryptBinary(
    Uint8List data,
    String password,
  );
  Future<String> decryptText(
    String cipherText,
    String password,
  );
  Future<Uint8List> decryptBinary(
    Uint8List data,
    String password,
  );
  Future<Uint8List> deriveKey(
    String password,
  );
}
