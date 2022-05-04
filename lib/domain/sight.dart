import 'package:places/domain/position.dart';
import 'package:places/res/app_strings.dart';

/// Модель данных достопримечательности.
class Sight {
  String name;
  Position? position;
  String details;
  Type type;
  List<String> images;
  String timeToVisit;
  String workingHours;

  Sight(
    this.name, {
    this.position,
    this.details = '',
    this.type = Type.special,
    this.images = const [],
    this.timeToVisit = '',
    this.workingHours = '',
  });
}

/// Тип достопримечательности.
enum Type {
  hotel,
  restaurant,
  special,
  park,
  museum,
  cafe,
}

extension TypeName on Type {
  String get name {
    switch (this) {
      case Type.hotel:
        return AppStrings.hotel;
      case Type.restaurant:
        return AppStrings.restaurant;
      case Type.special:
        return AppStrings.special;
      case Type.park:
        return AppStrings.park;
      case Type.museum:
        return AppStrings.museum;
      case Type.cafe:
        return AppStrings.cafe;
    }
  }
}
