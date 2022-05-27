// ignore_for_file: avoid_annotating_with_dynamic

import 'package:dio/dio.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

/// Вспомогательный класс для десериализации объектов из json.
abstract class RestDeserializer {

  /// Дерериализовать ответ сервера в виде json.
  static R map<R, T>(Response<dynamic> response, FromJson<T> fromJson) {
    if (response.data is List) {
      final list = response.data as List;

      return list.map((dynamic e) => fromJson(e as Map<String, dynamic>)).toList() as R;
    } else {

      return fromJson(response.data as Map<String, dynamic>) as R;
    }
  }
}
