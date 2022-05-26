import 'package:places/domain/model/position.dart';
import 'package:places/domain/repository/location_repository.dart';

/// Реализация репозитория получения текущих координат пользователя.
class LocationRepositoryImpl extends LocationRepository {

  @override
  Position getCurrentPosition() => const Position(55.75222, 37.61556);
}