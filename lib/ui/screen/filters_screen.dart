import 'dart:core';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/position.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/button/button_rounded.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:places/ui/widget/button/button_without_borders.dart';
import 'package:places/ui/widget/check_box/category_item.dart';

/// Экран фильтрации списка достопримечательностей.
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final List<Category> _categories = [
    Category(
      type: Type.cafe,
      icon: AppIcons.cafe,
      name: 'Отель',
    ),
    Category(
      type: Type.hotel,
      icon: AppIcons.hotel,
      name: 'Ресторан',
    ),
    Category(
      type: Type.museum,
      icon: AppIcons.museum,
      name: 'Особое место',
    ),
    Category(type: Type.park, icon: AppIcons.park, name: 'Парк'),
    Category(type: Type.special, icon: AppIcons.particularPlace, name: 'Музей'),
    Category(type: Type.restaurant, icon: AppIcons.restaurant, name: 'Кафе'),
  ];

  double startValue = 100;
  double endValue = 10000;

  RangeValues values = const RangeValues(100, 10000);
  int numberOfFound = 0;
  List<bool> _selected = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: ButtonSvgIcon(
          icon: AppIcons.arrow,
          color: Theme.of(context).colorScheme.main,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ButtonWithoutBorders(
              title: AppStrings.clear,
              height: 32,
              width: 82,
              color: Theme.of(context).colorScheme.green,
              onPressed: () {
                setState(() {
                  _clearCategories();
                  countSights();
                });
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.categories,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              SelectedCategories(
                selected: _selected,
                child: CategoriesGrid(
                  _categories,
                  onPressed: () {
                    setState(countSights);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(AppStrings.distance),
                  Text(
                    '${AppStrings.from} ${_convert(values.start)} ${AppStrings.to} ${_convert(values.end)}',
                  ),
                ],
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
              CountButtonText(
                count: numberOfFound,
                child: CategoriesButton(
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int countSights() {
    numberOfFound = 0;
    _selected.forEachIndexed((index, selectedCategory) {
      if (selectedCategory) {
        final type = _categories[index].type;
        numberOfFound =
            numberOfFound + mocks.where((sight) => sight.type == type).length;
      }
    });

    return numberOfFound;
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

  void _clearCategories() {
    _selected = _selected.map((e) => false).toList();
  }
}

/// Виджет списка категорий.
class CategoriesGrid extends StatefulWidget {
  final VoidCallback onPressed;
  final List<Category> _categories;

  const CategoriesGrid(this._categories, {required this.onPressed, Key? key})
      : super(key: key);

  @override
  State<CategoriesGrid> createState() => _CategoriesGridState();

  static _CategoriesGridState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CategoriesGridState>();
}

class _CategoriesGridState extends State<CategoriesGrid> {
  @override
  Widget build(BuildContext context) {
    final selected = SelectedCategories.of(context).selected;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget._categories.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => CategoryItem(
          widget._categories[index],
          isSelected: selected[index],
          onTap: () {
            setState(() {
              selected[index] = !selected[index];
              widget.onPressed();
            });
          },
        ),
      ),
    );
  }
}

/// Кнопка показать отфильтрованные достопримечательности.
class CategoriesButton extends StatefulWidget {
  final VoidCallback onPressed;

  const CategoriesButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  State<CategoriesButton> createState() => _CategoriesButtonState();
}

class _CategoriesButtonState extends State<CategoriesButton> {
  @override
  Widget build(BuildContext context) {
    final text = CountButtonText.of(context).title;

    return ButtonRounded(
      title: text.isEmpty ? AppStrings.show : text,
      onPressed: text.isEmpty ? null : widget.onPressed,
    );
  }
}

/// Виджет для проброса выбранных категорий вниз по дереву.
class SelectedCategories extends InheritedWidget {
  final List<bool> selected;

  const SelectedCategories({
    Key? key,
    required this.selected,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant SelectedCategories oldWidget) =>
      selected != oldWidget.selected;

  static SelectedCategories of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<SelectedCategories>();
    assert(result != null, 'No SelectedCategories found in context');

    return result!;
  }
}

/// Виджет для проброса количества выбранных достопримечательностей вниз по дереву.
class CountButtonText extends InheritedWidget {
  final int count;

  String get title => count != 0 ? '${AppStrings.show} ($count)' : '';

  const CountButtonText({
    Key? key,
    required this.count,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant CountButtonText oldWidget) =>
      count != oldWidget.count;

  static CountButtonText of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<CountButtonText>();
    assert(result != null, 'No CountButtonText found in context');

    return result!;
  }
}
