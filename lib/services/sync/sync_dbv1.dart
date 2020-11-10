import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:msgpack_dart/msgpack_dart.dart';
import 'package:path/path.dart' as path;
import 'package:pinenacl/secret.dart';

import '../../models/entries.dart';
import '../advance_crypto/advance_crypto_service.dart';
import '../authentication/authentication_service.dart';
import '../locator.dart';
import '../path/path_service.dart';
import 'sync_service.dart';

/// [SyncDBv1] implements the [SyncService]
///
/// DBv1 is the 3rd implementation of the local database.
/// This uses XSalsa20-Poly1305 (NaCl secretbox) for encryption.
/// Cloud sync is not yet implemented
@LazySingleton(as: SyncService)
class SyncDBv1 implements SyncService {
  static const fileName = 'db1.passwd1';

  final advanceCryptoService = locator<AdvanceCryptoService>();
  final authenticationService = locator<AuthenticationService>();
  final pathService = locator<PathService>();

  SecretBox box;

  Future checkBox() async {
    if (box == null) {
      final key = await advanceCryptoService.deriveKey(
        await authenticationService.readEncryptionKey(),
      );

      box = SecretBox(key);
    }
  }

  @override
  Future<Entries> readDatabaseLocally() async {
    try {
      await checkBox();

      final directory = await pathService.getDocDir();
      final filePath = path.join(directory.path, '$fileName');

      final dbFile = File(filePath);

      if (!(await dbFile.exists())) {
        return Entries(entries: []);
      }

      final fileContent = await dbFile.readAsBytes();
      final decryptedContent = box.decrypt(EncryptedMessage(
        nonce: fileContent.sublist(0, 24),
        cipherText: fileContent.sublist(24),
      ));

      final entries = Entries.fromJson(
        Map<String, dynamic>.from(
          deserialize(decryptedContent),
        ),
      );

      return entries;
    } catch (e) {
      print(e);
      return Entries(entries: []);
    }
  }

  @override
  Future<bool> syncronizeDatabaseLocally(Entries entries) async {
    try {
      entries.version = 1;
      await checkBox();

      final unencryptedData = serialize(entries);
      final encryptedData = box.encrypt(unencryptedData);

      final directory = await pathService.getDocDir();
      final filePath = path.join(directory.path, '$fileName');

      final dbFile = File(filePath);

      if (!(await dbFile.exists())) {
        await dbFile.createSync(recursive: true);
      }

      await dbFile.writeAsBytes(
        [...encryptedData.nonce, ...encryptedData.cipherText],
      );

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
