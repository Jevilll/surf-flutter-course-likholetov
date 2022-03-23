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
