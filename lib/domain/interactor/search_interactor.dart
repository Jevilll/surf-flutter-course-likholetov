import 'package:places/data/model/place_filter_request.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/result.dart';
import 'package:places/domain/repository/places_repository.dart';

/// Интерактор для работы поиска.
class SearchInteractor {
  late final PlacesRepository _placesRepository;
  final Set<String> _searchQueries = {};

  SearchInteractor(this._placesRepository);

  /// Найти место в зависимости от поискового запроса [searchQuery].
  Future<Result<List<Place>, Exception>> searchPlaces(String searchQuery) {
    _addToHistory(searchQuery);
    final filterRequest = PlaceFilterRequest(nameFilter: searchQuery);

    return _placesRepository.getFilteredPlaces(filterRequest: filterRequest);
  }

  /// Удалить поисковый запрос [searchQuery].
  void removeFromHistory(String searchQuery) {
    _searchQueries.remove(searchQuery);
  }

  /// Очистить историю поиска.
  void cleanHistory() {
    _searchQueries.clear();
  }

  void _addToHistory(String searchQuery) {
    _searchQueries.add(searchQuery);
  }
}
