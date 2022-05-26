import 'package:dio/dio.dart';

/// REST api для взаимодействия с сетью.
abstract class RestApi {

  /// REST запрос get
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? params,
  });

  /// REST запрос post
  Future<Response<dynamic>> post(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  });

  /// REST запрос put
  Future<Response<dynamic>> put(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  });

  /// REST запрос delete
  Future<void> delete(
    String path, {
    Map<String, dynamic>? params,
  });
}
