import 'package:equatable/equatable.dart';
import 'package:places/domain/model/place.dart';

/// Базовое событие экрана избранных мест.
abstract class FavoritesEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const FavoritesEvent();
}

/// Событие начала загрузки избранных мест.
class FavoritesGetPlacesEvent extends FavoritesEvent {}

/// Событие отображения загрузки избранных мест.
class FavoritesShowProgressEvent extends FavoritesEvent {}

/// Событие удаления места.
class FavoritesRemovePlaceEvent extends FavoritesEvent {
  final Place place;

  const FavoritesRemovePlaceEvent(this.place);
}
