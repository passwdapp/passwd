import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tuple/tuple.dart';

import '../../constants/api.dart';
import '../../models/entries.dart';
import '../../utils/loggers.dart';
import '../cloud_encryption/cloud_encryption_service.dart';
import '../locator.dart';
import 'cloud_sync_service.dart';

@LazySingleton(as: CloudSyncService)
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

  Future<Tuple2<bool, String>> fetchNonce(
    Uri endpoint,
    String secretKey,
    String accessToken,
  ) async {
    final apiEndpoint =
        '${endpoint.scheme}://${endpoint.authority}/$nonceEndpoint';

    try {
      final response = await dio.get(
        apiEndpoint,
        options: Options(headers: {
          'X-Secret-Key': secretKey,
          'Authorization': 'Bearer $accessToken',
        }),
      );

      return Tuple2(true, response.data['nonce'].toString());
    } catch (e) {
      Loggers.networkLogger.warning('Nonce fetch failed with the error $e');

      return Tuple2(false, '');
    }
  }

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
