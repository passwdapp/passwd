import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../utils/loggers.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio => Dio()..interceptors.add(LoggingInterceptor());
}

class LoggingInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions request) async {
    Loggers.networkLogger.info(
      '${request.method} ${request.uri.toString()}',
    );
    return super.onRequest(request);
  }

  @override
  Future onResponse(Response response) async {
    Loggers.networkLogger.info(
      '${response.request.uri.toString()} ${response.statusCode} - ${response.data}',
    );
    return super.onResponse(response);
  }

  @override
  Future onError(DioError error) async {
    Loggers.networkLogger.severe(
      '${error.message} - ${error.request.method} ${error.request.uri.toString()}',
    );
    return super.onError(error);
  }
}
