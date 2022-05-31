import 'dart:io';

import 'package:dio/dio.dart';
import 'package:places/data/api/api_urls.dart';
import 'package:places/data/api/interceptor.dart';
import 'package:places/data/api/rest_api.dart';
import 'package:places/data/exception/network_exception.dart';

/// Реализация REST api для взаимодействия с сетью.
class RestImpl extends RestApi {
  final Dio _dio;

  RestImpl()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiUrls.base,
            connectTimeout: 15000,
            receiveTimeout: 15000,
            sendTimeout: 15000,
          ),
        )..interceptors.add(LoggerInterceptor());

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? params,
  }) async =>
      _rawRequest(path, method: 'GET', params: params);

  @override
  Future<Response> post(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) async =>
      _rawRequest(path, method: 'POST', params: params, data: data);

  @override
  Future<Response<dynamic>> put(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) async =>
      _rawRequest(
        path,
        method: 'PUT',
        params: params,
        data: data,
      );

  @override
  Future<void> delete(
    String path, {
    Map<String, dynamic>? params,
  }) async =>
      _rawRequest(
        path,
        method: 'DELETE',
        params: params,
      );

  Future<Response> _rawRequest(
    String path, {
    required String method,
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.request<dynamic>(
        path,
        queryParameters: params,
        data: data,
        options: Options(method: method),
      );
    } on SocketException catch (e) {
      ConnectException(errorMessage: e.message);
      rethrow;
    }
    on DioError catch (e) {
      _getError(e);
      rethrow;
    }
  }

  void _getError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.response:
        ServerException(
          requestPath: dioError.requestOptions.path,
          statusCode: dioError.response?.statusCode,
          statusMessage: dioError.response?.statusMessage,
        );
        break;
      default:
        _getSocketError(dioError.error);
    }
  }

  // ignore: avoid_annotating_with_dynamic
  void _getSocketError(dynamic error) {
    if (error is SocketException) {
      ConnectException(errorMessage: error.message);
    } else {
      OtherException();
    }
  }
}
