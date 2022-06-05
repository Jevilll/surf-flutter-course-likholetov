import 'dart:async';

import 'package:places/data/model/place_filter_request.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/result.dart';
import 'package:places/domain/repository/location_repository.dart';
import 'package:places/domain/repository/places_repository.dart';

/// Интерактор для работы с местами.
class PlacesInteractor {
  final PlacesRepository _placesRepository;
  final LocationRepository _locationRepository;
  final List<Place> _favoritesList = [];
  final List<Place> _visitedList = [];
  late final _placesController =
      StreamController<Result<List<Place>, Exception>>.broadcast();
  Stream<Result<List<Place>, Exception>> get placesStream =>
      _placesController.stream;
  List<Place> _actualPlaces = [];

  PlacesInteractor(this._placesRepository, this._locationRepository) {
    placesStream.listen((result) {
      result.ifSuccess((places) {
        _actualPlaces = places;
      });
    });
  }

  /// Закрытие [StreamController].
  void dispose() {
    _placesController.close();
  }

  /// Возвращает место по его [id].
  Future<Result<Place, Exception>> getPlace({required int id}) {
    return _placesRepository.getPlace(id: id);
  }

  /// Возвращает список всех мест.
  Future<Result<List<Place>, Exception>> getPlaces() async {
    final result = await _placesRepository.getPlaces();

    final mappedResult = result.mapSuccess(_mapPlacesWithFavorites);
    _placesController.add(mappedResult);

    return mappedResult;
  }

  /// Возвращает отфильтрованный список мест.
  Future<Result<List<Place>, Exception>> getFilteredPlaces({
    double? minRadius,
    double? maxRadius,
    Set<Type>? types,
    String? searchQuery,
  }) async {
    final Set<String>? typeFilter = types?.map((type) => type.name).toSet();
    PlaceFilterRequest filterRequest;

    if (maxRadius != null) {
      final currentPosition = _locationRepository.getCurrentPosition();

      filterRequest = PlaceFilterRequest(
        lat: currentPosition.lat,
        lng: currentPosition.lng,
        radius: maxRadius,
        typeFilter: typeFilter,
        nameFilter: searchQuery,
      );
    } else {
      filterRequest = PlaceFilterRequest(
        typeFilter: typeFilter,
        nameFilter: searchQuery,
      );
    }

    final result =
        await _placesRepository.getFilteredPlaces(filterRequest: filterRequest);

    final filteredPlaces = maxRadius != null && minRadius != null
        ? result.mapSuccess((places) {
            return places
                .where((place) => (place.distance! / 1000) >= minRadius)
                .toList();
          })
        : result;

    _placesController.add(filteredPlaces);

    return filteredPlaces;
  }

  /// Добавить новое место.
  Future<Result<void, Exception>> addPlace(Place place) {
    return _placesRepository.addNewPlace(place);
  }

  /// Возвращает список избранных мест.
  List<Place> getFavorites() {
    return _favoritesList;
  }

  /// Добавить место в избранное.
  void addToFavorites(Place place) {
    _favoritesList.add(place);
    _updatePlaces();
  }

  /// Удалить место из избранного.
  void removeFromFavorites(Place place) {
    _favoritesList.removeWhere((element) => element.id == place.id);
    _updatePlaces();
  }

  /// Возвращает список посещенных мест.
  List<Place> getVisited() {
    return _visitedList;
  }

  /// Добавить место в посещенное.
  void addToVisited(Place place) {
    _visitedList.add(place);
  }

  void _updatePlaces() {
    _placesController
        .add(Result.success(_mapPlacesWithFavorites(_actualPlaces)));
  }

  List<Place> _mapPlacesWithFavorites(List<Place> places) {
    final placesWithFavorites = <Place>[];
    for (final place in places) {
      placesWithFavorites.add(place.copyWith(
        isFavorite:
            _favoritesList.where((favorite) => favorite.id == place.id).isNotEmpty,
      ));
    }

    return placesWithFavorites;
  }
}