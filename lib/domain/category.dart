/// Модель данных категории.
class Category {
  final String icon;
  final String name;
  bool isSelected;

  Category({required this.icon, required this.name, this.isSelected = false});
}
