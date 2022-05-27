import 'package:json_annotation/json_annotation.dart';

part '../../gen/data/model/place_filter_request.g.dart';

/// Модель запроса получения списка фильтрованных мест.
@JsonSerializable(createFactory: false, includeIfNull: false,)
class PlaceFilterRequest {
  final double? lat;
  final double? lng;
  final double? radius;
  final Set<String>? typeFilter;
  final String? nameFilter;

  PlaceFilterRequest({
    this.lat,
    this.lng,
    this.radius,
    this.typeFilter,
    this.nameFilter,
  });

  Map<String, dynamic> toJson() => _$PlaceFilterRequestToJson(this);
}