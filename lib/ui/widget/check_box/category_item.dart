import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/category.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_themes.dart';

/// Виджет элемента категории.
class CategoryItem extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem(this.category, {required this.isSelected, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              customBorder: const CircleBorder(),
              onTap: onTap,
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: theme.colorScheme.green.withOpacity(0.16),
                  shape: BoxShape.circle,
                ),
                child: UnconstrainedBox(
                  child: SvgPicture.asset(
                    category.icon,
                    height: 32,
                    width: 32,
                    color: theme.colorScheme.green,
                  ),
                ),
              ),
            ),
            if (isSelected) _CheckItem(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            category.name,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _CheckItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          color: theme.colorScheme.main,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          AppIcons.tick,
          height: 32,
          width: 32,
          color: theme.colorScheme.mainInverse,
        ),
      ),
    );
  }
}
