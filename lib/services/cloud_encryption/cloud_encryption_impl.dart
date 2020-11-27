import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:msgpack_dart/msgpack_dart.dart';
import 'package:pinenacl/secret.dart';

import '../../constants/api.dart';
import '../../models/entries.dart';
import '../cloud_hash/cloud_hash_service.dart';
import '../locator.dart';
import '../secure_kv/secure_kv.dart';
import 'cloud_encryption_service.dart';

@LazySingleton(as: CloudEncryptionService)
class CloudEncryptionImpl implements CloudEncryptionService {
  final cloudHashService = locator<CloudHashService>();
  final secureKVService = locator<SecureKVService>();

  SecretBox box;

  Future checkBox() async {
    final username = await secureKVService.getValue(USERNAME_KEY);
    final hash = await secureKVService.getValue(HASH_KEY);

    if (box == null) {
      final key = await cloudHashService.deriveSyncEncryptionPassword(
        username,
        hash,
      );

      box = SecretBox(key);
    }
  }

  @override
  Future<Entries> decrypt(Uint8List entries) async {
    await checkBox();

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
  Future<Uint8List> encrypt(Entries entries) async {
    await checkBox();

    final serializedEntries = serialize(entries.toJson());
    final encryptedEntries = box.encrypt(serializedEntries);

    return Uint8List.fromList([
      ...encryptedEntries.nonce,
      ...encryptedEntries.cipherText,
    ]);
  }
}
