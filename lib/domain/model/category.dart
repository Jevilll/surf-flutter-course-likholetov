import 'package:places/domain/model/place.dart';

/// Модель данных категории.
class Category {
  final String icon;
  final String name;
  final Type type;

  Category({required this.type, required this.icon, required this.name});
}
