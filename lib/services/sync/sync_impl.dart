import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

import '../../models/entries.dart';
import '../advance_crypto/advance_crypto_service.dart';
import '../authentication/authentication_service.dart';
import '../locator.dart';
import '../path/path_service.dart';
import 'sync_service.dart';

/// [SyncBinary] implements the [SyncService]
/// It consumes services like [AdvanceCryptoService], [AuthenticationService] and [PathService]
/// It provides an abstraction over the serialization, compression, encryption and storage of the DB
/// It uses encrypted JSON to store the DB on disk
///
/// Newer binary implementation is *not* compatible with this JSON based implementation
/// This one is deprecated, but is still here, coz just in case...
/// Using the binary implementation is strongly recommended
/// This is not injected currently
class SyncImpl implements SyncService {
  final String fileName = "db___test.passwd";

  final AdvanceCryptoService advanceCryptoService =
      locator<AdvanceCryptoService>();
  final AuthenticationService authenticationService =
      locator<AuthenticationService>();
  final PathService pathService = locator<PathService>();

  @override
  Future<Entries> readDatabaseLocally() async {
    try {
      Directory directory = await pathService.getDocDir();
      String filePath = path.join(directory.path, "$fileName");
      File dbFile = File(filePath);

      String fileContent = await dbFile.readAsString();
      String decryptedJson = await advanceCryptoService.decryptText(
        fileContent,
        await authenticationService.readEncryptionKey(),
      );

      Entries entries = Entries.fromJson(jsonDecode(decryptedJson));
      return entries;
    } catch (e) {
      print(e);
      return Entries(entries: []);
    }
  }

  @override
  Future<bool> syncronizeDatabaseLocally(Entries entries) async {
    try {
      String plainTextJson = jsonEncode(entries.toJson());
      String encryptedJson = await advanceCryptoService.encryptText(
        plainTextJson,
        await authenticationService.readEncryptionKey(),
      );

      Directory directory = await pathService.getDocDir();
      String filePath = path.join(directory.path, "$fileName");
      File dbFile = File(filePath);

      await dbFile.writeAsString(encryptedJson);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
