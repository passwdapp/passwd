import 'dart:convert';
import 'dart:io';

import 'package:passwd/models/entries.dart';
import 'package:passwd/services/advance_crypto/advance_crypto_service.dart';
import 'package:passwd/services/authentication/authentication_service.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/services/path/path_service.dart';
import 'package:passwd/services/sync/sync_service.dart';
import 'package:path/path.dart' as path;

// Newer binary implementation is *not* compatible with this JSON based implementation
// This one is deprecated, but is still here, coz just in case...
// Using the binary implementation is strongly recommended
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
