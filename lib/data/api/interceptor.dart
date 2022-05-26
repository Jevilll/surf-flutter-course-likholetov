import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/utils/common.dart';

/// Перехватчик, логирующий сетевые запросы.
class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i(
      'REQUEST[${options.method}] => PATH: ${options.path}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    const encoder = JsonEncoder.withIndent('  ');
    logger.i(
      'RESPONSE => PATH: ${response.requestOptions.path} \n ${encoder.convert(response.data)}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.i(
      'ERROR[${err.response?.statusCode} ${err.response?.statusMessage}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}
