import 'package:places/res/strings.dart';
/// Модель данных достопримечательности.
class Sight {
  String name;
  double lat;
  double long;
  String details;
  Type type;

  Sight(
    this.name, {
    this.lat = 0,
    this.long = 0,
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
        return monument;
      case Type.square:
        return square;
      case Type.lake:
        return lake;
      case Type.bridge:
        return bridge;
      case Type.other:
        return other;
    }
  }
}
