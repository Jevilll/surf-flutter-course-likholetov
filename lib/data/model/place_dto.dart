import 'package:freezed_annotation/freezed_annotation.dart';

part '../../gen/data/model/place_dto.freezed.dart';

part '../../gen/data/model/place_dto.g.dart';

/// Модель ответа с данными места.
@freezed
class PlaceDto with _$PlaceDto {
  const factory PlaceDto({
    required int id,
    required String name,
    required double lat,
    required double lng,
    required List<String> urls,
    required String placeType,
    required String description,
    double? distance,
  }) = _PlaceDto;

  factory PlaceDto.fromJson(Map<String, Object?> json) =>
      _$PlaceDtoFromJson(json);
}
