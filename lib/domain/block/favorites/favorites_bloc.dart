import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/domain/block/favorites/favorites_event.dart';
import 'package:places/domain/block/favorites/favorites_state.dart';
import 'package:places/domain/interactor/places_interactor.dart';

/// Блок экрана "Избранное".
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final PlacesInteractor _placesInteractor;

  FavoritesBloc(this._placesInteractor)
      : super(const FavoritesState.loading()) {
    on<FavoritesGetPlacesEvent>(_onFavoritesLoadedHandler);
    on<FavoritesRemovePlaceEvent>(_onFavoritesRemoveHandler);
  }

  Future<void> _onFavoritesLoadedHandler(
    FavoritesGetPlacesEvent _,
    Emitter emit,
  ) async {
    /// Эмуляция чтения записей из БД.
    await Future<void>.delayed(const Duration(seconds: 1));

    emit(await _getFavorites());
  }

  Future<void> _onFavoritesRemoveHandler(
    FavoritesRemovePlaceEvent removeEvent,
    Emitter emit,
  ) async {
    _placesInteractor.removeFromFavorites(removeEvent.place);

    emit(await _getFavorites());
  }

  Future<FavoritesState> _getFavorites() async {
    final values = await Future.wait([
      _placesInteractor.getFavorites(),
      _placesInteractor.getVisited(),
    ]);

    return FavoritesState.success(values[0], values[1]);
  }
}
