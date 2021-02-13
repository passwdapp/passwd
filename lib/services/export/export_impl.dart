import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:share/share.dart';

import '../../models/export.dart';
import '../database/database_service.dart';
import '../locator.dart';
import '../path/path_service.dart';
import 'export_service.dart';

@LazySingleton(as: ExportService)
class ExportImpl implements ExportService {
  static const encryptedFileName = 'db1.passwd1';
  static const unencryptedFileName = 'passwd_db.json';

  final pathService = locator<PathService>();
  final databaseService = locator<DatabaseService>();

  @override
  Future export(ExportType type) async {
    switch (type) {
      case ExportType.SHARE_UNENCRYPTED:
        await share_unencrypted();
        break;

      case ExportType.SAVE_TO_STORAGE_UNENCRYPTED:
        await save_unencrypted();
        break;

      case ExportType.SHARE_ENCRYPTED:
        await share_unencrypted();
        break;

      case ExportType.SAVE_TO_STORAGE_ENCRYPTED:
        throw UnimplementedError();
        break;
    }
  }

  Future share_unencrypted() async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      throw UnsupportedError('Share is only available on mobile devices');
    }

    final tempDir = await pathService.getTempDir();
    final tempDbPath = join(tempDir.path, encryptedFileName);
    final file = File(tempDbPath);

    await file.writeAsString(json.encode(databaseService.entries));
    await Share.shareFiles(
      [tempDbPath],
      mimeTypes: ['text/json', 'application/json'],
    );

    await file.delete();
  }

  Future share_encrypted() async {
    final directory = await pathService.getDocDir();
    final path = join(directory.path, unencryptedFileName);

    await Share.shareFiles(
      [path],
      mimeTypes: ['application/octet-stream'],
    );
  }

  Future save_unencrypted() async {
    if (Platform.isIOS) {
      throw UnsupportedError('Save is unavailable on iOS and windows');
    }

    final externalDir = Platform.isWindows
        ? await pathService.getDocDir()
        : await pathService.getExternalDirectory();
    final file = File(join(externalDir.path, './passwd.json'));

    await file.writeAsString(
      JsonEncoder.withIndent('  ').convert(databaseService.entries),
    ); // pretty print the json
  }
}
