import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tuple/tuple.dart';

import '../../constants/api.dart';
import '../../utils/loggers.dart';
import '../cloud_hash/cloud_hash_service.dart';
import '../locator.dart';
import 'cloud_users_service.dart';

class CloudUsersImpl implements CloudUsersService {
  final dio = locator<Dio>();

  final cloudHashService = locator<CloudHashService>();

  static const usersSuffix = '/users';

  static const loginSuffix = '/signin';
  static const registerSuffix = '/signup';
  static const refreshSuffix = '/refresh';

  static const loginEndpoint = '$supportedApiVersion$usersSuffix$loginSuffix';
  static const registerEndpoint =
      '$supportedApiVersion$usersSuffix$registerSuffix';
  static const refreshEndpoint =
      '$supportedApiVersion$usersSuffix$refreshSuffix';

  @override
  Future<void> ping(
    String secretKey,
    Uri endpoint,
  ) async {
    final apiEndpoint =
        '${endpoint.scheme}://${endpoint.authority}/$supportedApiVersion';

    try {
      await dio.get(
        apiEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Secret-Key': secretKey,
          },
        ),
      );
    } catch (e) {
      Loggers.networkLogger
          .warning('Unauthenticated ping failed with the error $e');

      throw Exception('Ping failed');
    }
  }

  @override
  Future<Tuple3<bool, String, String>> login(
    String username,
    String password,
    String secretKey,
    Uri endpoint,
  ) async {
    final apiEndpoint =
        '${endpoint.scheme}://${endpoint.authority}/$loginEndpoint';

    try {
      await ping(secretKey, endpoint);
      final response = await dio.post(
        apiEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Secret-Key': secretKey,
          },
        ),
        data: json.encode({
          'username': username,
          'password': cloudHashService.deriveSyncPassword(username, password),
        }),
      );

      return Tuple3<bool, String, String>(
        true,
        response.data['access_token'],
        response.data['refresh_token'],
      );
    } catch (e) {
      Loggers.networkLogger.warning('Login failed with the error $e');

      return Tuple3(false, '', '');
    }
  }

  @override
  Future<bool> register(
    String username,
    String password,
    String secretKey,
    Uri endpoint,
  ) async {
    final apiEndpoint =
        '${endpoint.scheme}://${endpoint.authority}/$registerEndpoint';

    try {
      await ping(secretKey, endpoint);
      await dio.post(
        apiEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Secret-Key': secretKey,
          },
        ),
        data: json.encode({
          'username': username,
          'password': cloudHashService.deriveSyncPassword(username, password),
        }),
      );

      return true;
    } catch (e) {
      Loggers.networkLogger.warning('Resister failed with the error $e');

      return false;
    }
  }

  @override
  Future<Tuple2<bool, String>> refresh(
    String refreshToken,
    String secretKey,
    Uri endpoint,
  ) async {
    final apiEndpoint =
        '${endpoint.scheme}://${endpoint.authority}/$refreshEndpoint';

    try {
      await ping(secretKey, endpoint);
      final response = await dio.post(
        apiEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Secret-Key': secretKey,
          },
        ),
        data: json.encode({
          'refresh_token': refreshToken,
        }),
      );

      return Tuple2(true, response.data['access_token'].toString());
    } catch (e) {
      Loggers.networkLogger.warning('Token refresh failed with the error $e');

      return Tuple2(false, '');
    }
  }
}
