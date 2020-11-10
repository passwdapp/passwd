import 'package:supercharged/supercharged.dart';

import '../locator.dart';
import '../secure_kv/secure_kv.dart';
import 'migration_service.dart';

class MigrationImpl implements MigrationService {
  static const versionKey = 'CURRENT_DB_VERSION';
  static const latestVersion = 1;
  final kvService = locator<SecureKVService>();

  @override
  Future migrate() async {
    final currentVersion = await currentDbVersion;

    if (!await needsMigration()) {
      return;
    }

    switch (currentVersion) {
      case 0:
        return;

      default:
        return;
    }
  }

  Future<int> get currentDbVersion async {
    final currentVersion =
        ((await kvService.getValue(versionKey)) ?? '0').toInt();

    return currentVersion;
  }

  Future setCurrentDbVersion(int version) async {
    await kvService.putValue(versionKey, version.toString());
  }

  @override
  Future<bool> needsMigration() async {
    if (await currentDbVersion < 1) {
      return true;
    }

    return false;
  }
}
