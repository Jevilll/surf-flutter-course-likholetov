import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/domain/model/place.dart';

part '../../../gen/domain/block/favorites/favorites_state.freezed.dart';

/// Состояние экрана избранных мест.
@freezed
class FavoritesState with _$FavoritesState {
  const FavoritesState._();

  const factory FavoritesState.loading() = _Loading;

  const factory FavoritesState.success(
    List<Place> favorites,
    List<Place> visited,
  ) = _Success;
}
