import 'package:dio/dio.dart';
import 'package:passwd/constants/api.dart';

import '../../models/entries.dart';
import '../cloud_encryption/cloud_encryption_service.dart';
import '../locator.dart';
import 'cloud_sync_service.dart';

class CloudSyncImpl implements CloudSyncService {
  final dio = locator<Dio>();
  final cloudEncryptionService = locator<CloudEncryptionService>();

  static const uploadsSuffix = '/uploads';

  static const nonceSuffix = '/nonce';
  static const downloadSuffix = '/get';
  static const uploadSuffix = '/new';

  static const nonceEndpoint = '$supportedApiVersion$uploadsSuffix$nonceSuffix';
  static const downloadEndpoint =
      '$supportedApiVersion$uploadsSuffix$downloadSuffix';
  static const uploadEndpoint =
      '$supportedApiVersion$uploadsSuffix$uploadSuffix';

  @override
  Future<Entries> fetchRemoteEntries(
    Uri endpoint,
    String secretKey,
    String accessToken,
    String encryptionPassword,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> syncLocalEntries(
    Entries entries,
    Uri endpoint,
    String secretKey,
    String accessToken,
    String encryptionPassword,
  ) async {
    throw UnimplementedError();
  }
}
