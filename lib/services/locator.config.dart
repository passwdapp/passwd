// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import 'advance_crypto/advance_crypto_aes.dart';
import 'advance_crypto/advance_crypto_service.dart';
import 'authentication/authentication_impl.dart';
import 'authentication/authentication_service.dart';
import 'biometrics/biometrics_localauth.dart';
import 'biometrics/biometrics_service.dart';
import 'crypto/crypto_crypt.dart';
import 'crypto/crypto_service.dart';
import 'favicon/favicon_http.dart';
import 'favicon/favicon_service.dart';
import 'in_memory/in_memory_impl.dart';
import 'in_memory/in_memory_service.dart';
import 'password/password_impl.dart';
import 'password/password_service.dart';
import 'path/path_path_provider.dart';
import 'path/path_service.dart';
import 'qr/qr_flutter_barcode_scanner.dart';
import 'qr/qr_service.dart';
import 'secure_kv/secure_kv_securestorage.dart';
import 'secure_kv/secure_kv.dart';
import 'sync/sync_binary.dart';
import 'sync/sync_service.dart';
import 'third_party.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartySevices = _$ThirdPartySevices();
  gh.lazySingleton<AdvanceCryptoService>(() => AdvanceCryptoAes());
  gh.lazySingleton<AuthenticationService>(() => AuthenticationImpl());
  gh.lazySingleton<BiometricsService>(() => BiometricsLocalAuth());
  gh.lazySingleton<CryptoService>(() => CryptoCrypt());
  gh.lazySingleton<FaviconService>(() => FaviconHttp());
  gh.lazySingleton<InMemoryService>(() => InMemoryImpl());
  gh.lazySingleton<NavigationService>(
      () => thirdPartySevices.navigationService);
  gh.lazySingleton<PasswordService>(() => PasswordImpl());
  gh.lazySingleton<PathService>(() => PathPathProvider());
  gh.lazySingleton<QRService>(() => QRFlutterBarcodeScanner());
  gh.lazySingleton<SecureKVService>(() => SecureKVSecureStorage());
  gh.lazySingleton<SyncService>(() => SyncImpl());
  return get;
}

class _$ThirdPartySevices extends ThirdPartySevices {
  @override
  NavigationService get navigationService => NavigationService();
}
