import 'dart:typed_data';

import 'package:msgpack_dart/msgpack_dart.dart';
import 'package:pinenacl/secret.dart';

import '../../models/entries.dart';
import '../cloud_hash/cloud_hash_service.dart';
import '../locator.dart';
import 'cloud_encryption_service.dart';

class CloudEncryptionImpl implements CloudEncryptionService {
  final cloudHashService = locator<CloudHashService>();

  SecretBox box;

  Future checkBox(
    String username,
    String password,
  ) async {
    if (box == null) {
      final key = await cloudHashService.deriveSyncEncryptionPassword(
        username,
        password,
      );

      box = SecretBox(key);
    }
  }

  @override
  Future<Entries> decrypt(
    Uint8List entries,
    String username,
    String password,
  ) async {
    await checkBox(username, password);

    final nonce = entries.sublist(0, 24);
    final data = entries.sublist(24);

    final decryptedEntries = box.decrypt(EncryptedMessage(
      cipherText: data,
      nonce: nonce,
    ));

    return Entries.fromJson(
      Map<String, dynamic>.from(deserialize(decryptedEntries)),
    );
  }

  @override
  Future<Uint8List> encrypt(
    Entries entries,
    String username,
    String password,
  ) async {
    await checkBox(username, password);

    final serializedEntries = serialize(entries);
    final encryptedEntries = box.encrypt(serializedEntries);

    return Uint8List.fromList([
      ...encryptedEntries.nonce,
      ...encryptedEntries.cipherText,
    ]);
  }
}
