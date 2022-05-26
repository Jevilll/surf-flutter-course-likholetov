import 'package:places/domain/model/position.dart';

/// Репозиторий получения текущих координат пользователя.
abstract class LocationRepository {

  /// Получить текущие координаты.
  Position getCurrentPosition();
}