/// Сетевая ошибка.
abstract class NetworkException implements Exception {}

/// Ошибка соединения с интернетом.
class ConnectException extends NetworkException {
  final String errorMessage;

  ConnectException({required this.errorMessage});
}

/// Ошибка с сервера.
class ServerException extends NetworkException {
  final String requestPath;
  final int? statusCode;
  final String? statusMessage;

  ServerException({required this.requestPath, this.statusCode, this.statusMessage});

  @override
  String toString() {
    return 'В запросе $requestPath возникла ошибка: $statusCode $statusMessage';
  }
}

/// Неопределенная ошибка.
class OtherException extends NetworkException {}