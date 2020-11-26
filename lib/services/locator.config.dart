// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'advance_crypto/advance_crypto_aes.dart';
import 'advance_crypto/advance_crypto_service.dart';
import 'authentication/authentication_biometric_storage.dart';
import 'authentication/authentication_service.dart';
import 'biometrics/biometrics_biometric_storage.dart';
import 'biometrics/biometrics_service.dart';
import 'cloud_encryption/cloud_encryption_impl.dart';
import 'cloud_encryption/cloud_encryption_service.dart';
import 'cloud_hash/cloud_hash_impl.dart';
import 'cloud_hash/cloud_hash_service.dart';
import 'cloud_sync/cloud_sync_impl.dart';
import 'cloud_sync/cloud_sync_service.dart';
import 'cloud_users/cloud_users_impl.dart';
import 'cloud_users/cloud_users_service.dart';
import 'crypto/crypto_crypt.dart';
import 'crypto/crypto_service.dart';
import 'database/database_impl.dart';
import 'database/database_service.dart';
import 'dio.dart';
import 'favicon/favicon_new.dart';
import 'favicon/favicon_service.dart';
import 'migration/migration_impl.dart';
import 'migration/migration_service.dart';
import 'password/password_impl.dart';
import 'password/password_service.dart';
import 'path/path_path_provider.dart';
import 'path/path_service.dart';
import 'qr/qr_flutter_barcode_scanner.dart';
import 'qr/qr_service.dart';
import 'secure_kv/secure_kv_securestorage.dart';
import 'secure_kv/secure_kv_sharedprefs.dart' as passwd;
import 'secure_kv/secure_kv.dart';
import 'sync/sync_dbv1.dart';
import 'sync/sync_service.dart';

/// Environment names
const _mobile = 'mobile';
const _desktop = 'desktop';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final dioModule = _$DioModule();
  gh.lazySingleton<AdvanceCryptoService>(() => AdvanceCryptoAes());
  gh.lazySingleton<AuthenticationService>(
      () => AuthenticationBiometricStorage());
  gh.lazySingleton<BiometricsService>(() => BiometricsBiometricStorage());
  gh.lazySingleton<CloudEncryptionService>(() => CloudEncryptionImpl());
  gh.lazySingleton<CloudHashService>(() => CloudHashImpl());
  gh.lazySingleton<CloudSyncService>(() => CloudSyncImpl());
  gh.lazySingleton<CloudUsersService>(() => CloudUsersImpl());
  gh.lazySingleton<CryptoService>(() => CryptoCrypt());
  gh.lazySingleton<DatabaseService>(() => DatabaseImpl());
  gh.lazySingleton<Dio>(() => dioModule.dio);
  gh.lazySingleton<FaviconService>(() => FaviconNew());
  gh.lazySingleton<MigrationService>(() => MigrationImpl());
  gh.lazySingleton<PasswordService>(() => PasswordImpl());
  gh.lazySingleton<PathService>(() => PathPathProvider());
  gh.lazySingleton<QRService>(() => QRFlutterBarcodeScanner());
  gh.lazySingleton<SecureKVService>(() => SecureKVSecureStorage(),
      registerFor: {_mobile});
  gh.lazySingleton<SecureKVService>(() => passwd.SecureKVSecureStorage(),
      registerFor: {_desktop});
  gh.lazySingleton<SyncService>(() => SyncDBv1());
  return get;
}

class _$DioModule extends DioModule {}
