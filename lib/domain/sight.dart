import 'package:places/res/app_strings.dart';

/// Модель данных достопримечательности.
class Sight {
  String name;
  double lat;
  double long;
  String shortDescription;
  String details;
  Type type;

  Sight(
    this.name, {
    this.lat = 0,
    this.long = 0,
    this.shortDescription = '',
    this.details = '',
    this.type = Type.other,
  });
}

/// Тип достопримечательности.
enum Type {
  monument,
  square,
  lake,
  bridge,
  other,
}

extension TypeName on Type {
  String get name {
    switch (this) {
      case Type.monument:
        return AppStrings.monument;
      case Type.square:
        return AppStrings.square;
      case Type.lake:
        return AppStrings.lake;
      case Type.bridge:
        return AppStrings.bridge;
      case Type.other:
        return AppStrings.other;
    }
  }
}
