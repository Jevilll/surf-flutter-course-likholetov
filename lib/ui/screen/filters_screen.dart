import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/position.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/button/button_rounded.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:places/ui/widget/button/button_without_borders.dart';
import 'package:places/ui/widget/check_box/category_item.dart';
import 'package:places/utils/common.dart';

/// Экран фильтрации списка достопримечательностей.
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final List<Category> _categories = [
    Category(
      icon: AppIcons.tick,
      name: 'Отель',
    ),
    Category(
      icon: AppIcons.clear,
      name: 'Ресторан',
    ),
    Category(
      icon: AppIcons.settings,
      name: 'Особое место',
    ),
    Category(icon: AppIcons.photo, name: 'Парк'),
    Category(icon: AppIcons.photo, name: 'Музей'),
    Category(icon: AppIcons.photo, name: 'Кафе'),
  ];

  double startValue = 100;
  double endValue = 10000;

  RangeValues values = const RangeValues(100, 10000);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonSvgIcon(
                icon: AppIcons.arrow,
                color: Theme.of(context).colorScheme.main,
                onPressed: () {},
              ),
              ButtonWithoutBorders(
                title: AppStrings.clear,
                height: 32,
                width: 82,
                color: Theme.of(context).colorScheme.green,
                onPressed: () {
                  logger.i('Нажатие на кнопку в очистить');
                },
              ),
            ],
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.categories,
              style: AppTextStyles.superSmall,
            ),
          ),
          _CategoriesGrid(_categories),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(AppStrings.distance),
                Text(
                  '${AppStrings.from} ${_convert(values.start)} ${AppStrings.to} ${_convert(values.end)}',
                ),
              ],
            ),
          ),
          RangeSlider(
            min: 100,
            max: 10000,
            values: values,
            divisions: 99,
            onChanged: (newRange) {
              setState(() {
                values = newRange;
              });
            },
          ),
          const Spacer(),
          ButtonRounded(
            title: AppStrings.show,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  String _convert(double value) {
    return value < 1000
        ? '${value.toStringAsFixed(0)} ${AppStrings.m}'
        : '${(value / 1000).toStringAsFixed(0)} ${AppStrings.km}';
  }

  bool _isPositionNear(Position checkPoint, Position centerPoint, double km) {
    const ky = 40000 / 360;
    final kx = cos(pi * centerPoint.lat / 180.0) * ky;
    final dx = (centerPoint.lng - checkPoint.lng).abs() * kx;
    final dy = (centerPoint.lat - checkPoint.lat).abs() * ky;

    return sqrt(dx * dx + dy + dy) <= km;
  }
}

/// Виджет списка категорий.
class _CategoriesGrid extends StatefulWidget {
  final List<Category> _categories;

  const _CategoriesGrid(this._categories, {Key? key}) : super(key: key);

  @override
  State<_CategoriesGrid> createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<_CategoriesGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        itemCount: widget._categories.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => CategoryItem(
          widget._categories[index],
          onTap: () {
            setState(() {
              widget._categories[index].isSelected =
                  !widget._categories[index].isSelected;
            });
          },
        ),
      ),
    );
  }
}
