import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/domain/model/position.dart';
import 'package:places/res/app_strings.dart';

part '../../gen/domain/model/place.freezed.dart';

/// Модель данных места.
@freezed
class Place with _$Place {

  factory Place({
    required final int id,
    required final String name,
    required final Position position,
    required final String description,
    required final Type type,
    required final List<String> urls,
    double? distance,
    @Default(false) bool isFavorite,
    @Default('') String timeToVisit,
    @Default('') final String workingHours,
  }) = _Place;
}

/// Тип места.
enum Type {
  temple,
  monument,
  park,
  theatre,
  museum,
  hotel,
  restaurant,
  cafe,
  other,
}

extension TypeName on Type {
  String get name {
    switch (this) {
      case Type.temple:
        return AppStrings.temple;
      case Type.monument:
        return AppStrings.monument;
      case Type.park:
        return AppStrings.park;
      case Type.theatre:
        return AppStrings.theatre;
      case Type.museum:
        return AppStrings.museum;
      case Type.hotel:
        return AppStrings.hotel;
      case Type.restaurant:
        return AppStrings.restaurant;
      case Type.cafe:
        return AppStrings.cafe;
      case Type.other:
        return AppStrings.other;
    }
  }
}
