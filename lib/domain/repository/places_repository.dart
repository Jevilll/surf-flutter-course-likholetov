import 'package:places/data/model/place_filter_request.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/result.dart';

/// Репозиторий сетевого взаимодействия с местами.
abstract class PlacesRepository {
  /// Получить место по идентификатору [id].
  Future<Result<Place, Exception>> getPlace({required int id});

  /// Получить список всех мест.
  Future<Result<List<Place>, Exception>> getPlaces();

  /// Добавить новое место [newPlace].
  Future<Result<void, Exception>> addNewPlace(Place newPlace);

  Future<Result<List<Place>, Exception>> getFilteredPlaces({
    required PlaceFilterRequest filterRequest,
  });
}
