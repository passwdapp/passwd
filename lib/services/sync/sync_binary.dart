import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:injectable/injectable.dart';
import 'package:msgpack_dart/msgpack_dart.dart';
import 'package:passwd/models/entries.dart';
import 'package:passwd/services/advance_crypto/advance_crypto_service.dart';
import 'package:passwd/services/authentication/authentication_service.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/services/path/path_service.dart';
import 'package:passwd/services/sync/sync_service.dart';
import 'package:path/path.dart' as path;

@LazySingleton(as: SyncService)
class SyncImpl implements SyncService {
  // TODO: change DB name for production
  final String fileName = "db___test__bin.passwd";
  // final String fileName = "db___prod__00.passwd";

  final AdvanceCryptoService advanceCryptoService =
      locator<AdvanceCryptoService>();
  final AuthenticationService authenticationService =
      locator<AuthenticationService>();
  final PathService pathService = locator<PathService>();

  @override
  Future<Entries> readDatabaseLocally() async {
    try {
      String filePath = path.join(await pathService.getDocDir(), "./$fileName");
      File dbFile = File(filePath);

      Uint8List fileContent = await dbFile.readAsBytes();
      Uint8List decryptedContent = await advanceCryptoService.decryptBinary(
        fileContent,
        await authenticationService.readEncryptionKey(),
      );
      Uint8List uncompressedContent = GZipDecoder().decodeBytes(
        decryptedContent,
      );

      Entries entries = Entries.fromJson(
        Map<String, dynamic>.from(
          deserialize(uncompressedContent),
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
      Uint8List unencryptedData = serialize(entries.toJson());
      Uint8List unencryptedCompressedData =
          GZipEncoder().encode(unencryptedData);
      Uint8List encryptedJson = await advanceCryptoService.encryptBinary(
        unencryptedCompressedData,
        await authenticationService.readEncryptionKey(),
      );

      String filePath = path.join(await pathService.getDocDir(), "./$fileName");
      File dbFile = File(filePath);

      await dbFile.writeAsBytes(encryptedJson);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
