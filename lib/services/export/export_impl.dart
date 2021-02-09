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
  final pathService = locator<PathService>();
  final databaseService = locator<DatabaseService>();

  @override
  Future export(ExportType type) async {
    switch (type) {
      case ExportType.SHARE_UNENCRYPTED:
        await share_unencrypted();
        break;

      case ExportType.SAVE_TO_STORAGE_UNENCRYPTED:
        throw UnimplementedError();
    }
  }

  Future share_unencrypted() async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      throw UnsupportedError('Share is only available on mobile devices');
    }

    final tempDir = await pathService.getTempDir();
    final tempDbPath = join(tempDir.path, 'passwd_db.json');
    final file = File(tempDbPath);

    await file.writeAsString(json.encode(databaseService.entries));
    await Share.shareFiles(
      [tempDbPath],
      mimeTypes: ['text/json', 'application/json'],
    );

    await file.delete();
  }
}
