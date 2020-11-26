import 'dart:typed_data';

abstract class CloudHashService {
  String deriveSyncPassword(
    String username,
    String password,
  );

  Future<Uint8List> deriveSyncEncryptionPassword(
    String username,
    String password,
  );
}
