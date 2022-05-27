import 'package:places/data/model/place_dto.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/position.dart';

/// Маппер моделей домен [Place] <=> данных [PlaceDto].
class PlaceMapper {

  /// Смапить [PlaceDto] в [Place].
  Place fromDto(PlaceDto placeDto) => Place(
        id: placeDto.id,
        name: placeDto.name,
        position: Position(
          placeDto.lat,
          placeDto.lng,
        ),
        type: _placeTypeFromString(placeDto.placeType),
        urls: placeDto.urls,
        description: placeDto.description,
        distance: placeDto.distance,
      );

  PlaceDto toDto(Place place) => PlaceDto(
        id: place.id,
        name: place.name,
        lat: place.position.lat,
        lng: place.position.lng,
        urls: place.urls,
        placeType: _placeTypeToString(place.type),
        description: place.description,
      );

  String _placeTypeToString(Type type) => type.name;

  Type _placeTypeFromString(String value) => Type.values.firstWhere(
        (element) => element.name == value,
        orElse: () => Type.other,
      );
}
