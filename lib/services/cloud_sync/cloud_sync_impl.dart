import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tuple/tuple.dart';

import '../../constants/api.dart';
import '../../models/entries.dart';
import '../../utils/loggers.dart';
import '../cloud_encryption/cloud_encryption_service.dart';
import '../cloud_users/cloud_users_service.dart';
import '../database/database_service.dart';
import '../locator.dart';
import '../secure_kv/secure_kv.dart';
import 'cloud_sync_service.dart';

@LazySingleton(as: CloudSyncService)
class CloudSyncImpl implements CloudSyncService {
  final dio = locator<Dio>();

  final databaseService = locator<DatabaseService>();
  final cloudEncryptionService = locator<CloudEncryptionService>();
  final secureKVService = locator<SecureKVService>();
  final cloudUsersService = locator<CloudUsersService>();

  static const uploadsSuffix = '/protected/uploads';

  static const nonceSuffix = '/nonce';
  static const downloadSuffix = '/get';
  static const uploadSuffix = '/new';

  static const nonceEndpoint = '$supportedApiVersion$uploadsSuffix$nonceSuffix';
  static const downloadEndpoint =
      '$supportedApiVersion$uploadsSuffix$downloadSuffix';
  static const uploadEndpoint =
      '$supportedApiVersion$uploadsSuffix$uploadSuffix';

  // success, nonce
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

  // uri, secret key, access token
  Future<Tuple3<Uri, String, String>> getStoredData() async {
    final endpoint = Uri.parse(await secureKVService.getValue(URI_KEY));
    final secretKey = await secureKVService.getValue(SECRETKEY_KEY);
    final tokenIssueTime = int.parse(
      await secureKVService.getValue(TOKEN_ISSUE_TIMESTAMP_KEY),
    );

    final currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    // Refresh token is the current token is older than 50 mins
    // Access tokens expire every 1hr
    if (tokenIssueTime + (50 * 60 * 1000) <= currentTimestamp) {
      final refreshToken = await secureKVService.getValue(REFRESH_TOKEN_KEY);
      await cloudUsersService.refresh(refreshToken, secretKey, endpoint);
    }

    final accessToken = await secureKVService.getValue(ACCESS_TOKEN_KEY);

    return Tuple3(endpoint, secretKey, accessToken);
  }

  // Entries, is nonce same, is sync successful, should push
  @override
  Future<Tuple4<Entries, bool, bool, bool>> fetchRemoteEntries([
    Tuple3<Uri, String, String> storedDataArg,
  ]) async {
    final storedData = storedDataArg ?? await getStoredData();
    final endpoint = storedData.item1;
    final secretKey = storedData.item2;
    final accessToken = storedData.item3;

    final localEntries = databaseService.entries ?? Entries(entries: []);

    final nonceTuple = await fetchNonce(endpoint, secretKey, accessToken);
    if (!nonceTuple.item1) {
      Loggers.syncLogger.severe('Remote nonce fetch failed');
      Loggers.syncLogger.severe(
          'This usually happens when the server has no DB, so allowing push');
    }
    final nonce = nonceTuple.item2;
    final storedNonce = await secureKVService.getValue(NONCE_KEY);

    // old nonce checking ahead
    // new nonce checking is implemented below
    // if (storedNonce != null && storedNonce != '' && nonce == storedNonce) {
    //   Loggers.syncLogger.info(
    //       'Remote nonce same as local nonce, cancelling merge, cancelling push...');

    //   return Tuple4(
    //     localEntries,
    //     true,
    //     true,
    //     false,
    //   );
    // }

    final nonceInt = int.tryParse(nonce);
    if (nonceInt == null) {
      Loggers.syncLogger.info(
          'Looks like the server still has the old "random" nonce, cancelling merge, allowing push to get the server to the new "sequential" format');

      return Tuple4(
        localEntries,
        false,
        true,
        true,
      );
    }

    final storedNonceInt = int.tryParse(storedNonce);
    if (storedNonceInt == null) {
      Loggers.syncLogger.info(
          'Looks like the server has the new "sequential" nonce while the client has the old "random" nonce. Forcing a remote merge while cancelling push as its guaranteed that the server will have a newer version');
    } else {
      Loggers.syncLogger.info(
          'Looks like both the client and the server have a "sequential" nonce, proceeding with the normal procedure');
    }

    final storedUpdateTimestamp =
        await secureKVService.getValue(UPLOAD_TIMESTAMP_KEY);
    final localUpdateTimestamp = localEntries.lastUpdated.toString();

    if (storedNonceInt == nonceInt) {
      if (storedUpdateTimestamp == localUpdateTimestamp) {
        Loggers.syncLogger.info(
            'Both the nonce and the timestamp are the same. This means both the remote and the local DB is the same, cancelling merge, canelling sync');

        return Tuple4(
          localEntries,
          true,
          true,
          false,
        );
      } else {
        Loggers.syncLogger.warning(
            'Weird situation where the nonce is the same but the timestamp is not. Proceeding with sync');
      }
    } else {
      Loggers.syncLogger.info(
          'Stored nonce is not equal to the remote nonce. This requires a full sync and merge');
    }

    try {
      final response = await dio.get<List<int>>(
        '${endpoint.scheme}://${endpoint.authority}/$downloadEndpoint',
        options: Options(headers: {
          'X-Secret-Key': secretKey,
          'Authorization': 'Bearer $accessToken',
        }, responseType: ResponseType.bytes),
      );

      final decryptedData = await cloudEncryptionService.decrypt(response.data);

      if (localEntries.lastUpdated == null ||
          localEntries.lastUpdated <= decryptedData.lastUpdated) {
        Loggers.syncLogger.info('Merge successful, cancelling push');
        await databaseService.setEntries(decryptedData);
        return Tuple4(
          decryptedData,
          false,
          true,
          false,
        );
      }

      Loggers.syncLogger.info(
          'This client has a newer DB, cancelling merge, allowing push...');
      return Tuple4(localEntries, false, false, true);
    } catch (e) {
      Loggers.networkLogger.warning('Remote DB fetch failed with the error $e');
      Loggers.syncLogger.warning('Remote merge failed');
      Loggers.syncLogger.warning(
          'This usually happens when the server has no DB, so allowing push');

      return Tuple4(
        localEntries,
        false,
        false,
        true,
      );
    }
  }

  @override
  Future<bool> syncLocalEntries() async {
    final storedData = await getStoredData();
    final endpoint = storedData.item1;
    final secretKey = storedData.item2;
    final accessToken = storedData.item3;

    final remoteEntryData = await fetchRemoteEntries(storedData);
    final shouldPush = remoteEntryData.item4;

    if (!shouldPush) {
      Loggers.syncLogger.info(
          'Sync determined that local entries should not be pushed, cancelling push...');

      return false;
    }

    Loggers.syncLogger.info('Pushing the DB to the server');

    final encryptedData =
        await cloudEncryptionService.encrypt(databaseService.entries);

    try {
      final response = await dio.post(
        '${endpoint.scheme}://${endpoint.authority}/$uploadEndpoint',
        options: Options(headers: {
          'X-Secret-Key': secretKey,
          'Authorization': 'Bearer $accessToken',
        }),
        data: FormData.fromMap({
          'db': MultipartFile.fromBytes(encryptedData, filename: 'db1.passwd1'),
        }),
      );

      await secureKVService.putValue(
          UPLOAD_TIMESTAMP_KEY,
          (databaseService.entries.lastUpdated ??
                  DateTime.now().millisecondsSinceEpoch)
              .toString());

      final nonce = response.data['nonce'].toString();
      await secureKVService.putValue(NONCE_KEY, nonce);

      return true;
    } catch (e) {
      Loggers.networkLogger
          .warning('Push to the server failed with the error $e');
      Loggers.syncLogger.warning('Push failed due to network error');

      return false;
    }
  }
}
