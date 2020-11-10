import 'package:passwd/services/authentication/authentication_service.dart';
import 'package:supercharged/supercharged.dart';

import '../locator.dart';
import '../secure_kv/secure_kv.dart';
import 'migration_service.dart';

/// [MigrationImpl] implements the [MigrationService].
/// It is used to migrate between DB versions.
///
/// DB versions:
/// - v0:
///   1. Uses msgpack to serialize the raw data
///   2. GZips the serialized data
///   3. Uses AES-256-CTR with a random IV to encrypt the data
/// - v1:
///   1. Uses msgpack to serialize the raw data
///   2. Uses XSalsa20-Poly1305 to encrypt the serialized data (NaCl secretbox)
///
///
/// DB Changelog:
/// - v0:
///   - Initial DB
/// - v1:
///   - Move from **AES-256-CTR** to **XSalsa20-Poly1305** (NaCl secretbox)
class MigrationImpl implements MigrationService {
  static const versionKey = 'CURRENT_DB_VERSION';
  static const latestVersion = 1;

  final kvService = locator<SecureKVService>();
  final authenticationService = locator<AuthenticationService>();

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
