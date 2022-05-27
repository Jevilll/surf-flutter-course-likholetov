import 'dart:async';

import 'package:places/data/model/place_filter_request.dart';
import 'package:places/data/repository/location_repository_impl.dart';
import 'package:places/data/repository/places_repository_impl.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/result.dart';
import 'package:places/domain/repository/location_repository.dart';
import 'package:places/domain/repository/places_repository.dart';

/// Интерактор для работы с местами.
class PlacesInteractor {
  late final PlacesRepository _placesRepository;
  late final LocationRepository _locationRepository;
  final List<Place> _favoritesList = [];
  final List<Place> _visitedList = [];

  PlacesInteractor() {
    _placesRepository = PlacesRepositoryImpl();
    _locationRepository = LocationRepositoryImpl();
  }

  /// Возвращает место по его [id].
  Future<Result<Place, Exception>> getPlace({required int id}) {
    return _placesRepository.getPlace(id: id);
  }

  /// Возвращает список всех мест.
  Future<Result<List<Place>, Exception>> getPlaces() async {
    final Result<List<Place>, Exception> result = await _placesRepository.getPlaces();

    return result.when(
      success: (places) {
        return Result.success(_mapPlacesWithFavorites(places));
      },
      failure: (failure) {
        return Result.failure(failure);
      },
    );
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

    return maxRadius != null && minRadius != null
        ? result.when(
            success: (places) {
              final placesOverMinimumRadius = places
                  .where((place) => (place.distance! / 1000) >= minRadius)
                  .toList();

              return Result.success(placesOverMinimumRadius);
            },
            failure: (failure) {
              return Result.failure(failure);
            },
          )
        : result;
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
  }

  /// Удалить место из избранного.
  void removeFromFavorites(Place place) {
    _favoritesList.remove(place);
  }

  /// Возвращает список посещенных мест.
  List<Place> getVisited() {
    return _visitedList;
  }

  /// Добавить место в посещенное.
  void addToVisited(Place place) {
    _visitedList.add(place);
  }

  List<Place> _mapPlacesWithFavorites(List<Place> places) {
    final placesWithFavorites = <Place>[];
    for (final place in places) {
      final isFavorite = _favoritesList.contains(place);
      placesWithFavorites.add(place.copyWith(
        isFavorite: isFavorite,
      ));
    }

    return placesWithFavorites;
  }
}

final placesInteractor = PlacesInteractor();
