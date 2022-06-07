import 'package:mobx/mobx.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/result.dart';
import 'package:places/domain/repository/places_repository.dart';
import 'package:places/ui/screen/place_list_screen.dart';

part '../gen/store/place_list_store.g.dart';

/// Стор экрана [PlaceListScreen].
class PlaceListStore = PlaceListStoreBase with _$PlaceListStore;

abstract class PlaceListStoreBase with Store {
  final PlacesRepository _placesRepository;

  @observable
  ObservableFuture<Result<List<Place>, Exception>>? getPlacesFuture;

  PlaceListStoreBase(this._placesRepository);

  /// Получить список мест.
  @action
  void getPlaces() {
    final future = _placesRepository.getPlaces();
    getPlacesFuture = ObservableFuture(future);
  }
}
