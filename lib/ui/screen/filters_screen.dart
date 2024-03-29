import 'dart:core';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/interactor/places_interactor.dart';
import 'package:places/domain/model/category.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/position.dart';
import 'package:places/domain/model/result.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/button/button_rounded.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:places/ui/widget/button/button_without_borders.dart';
import 'package:places/ui/widget/check_box/category_item.dart';
import 'package:provider/provider.dart';

/// Экран фильтрации списка мест.
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
    Category(type: Type.other, icon: AppIcons.particularPlace, name: 'Музей'),
    Category(type: Type.restaurant, icon: AppIcons.restaurant, name: 'Кафе'),
  ];

  double startValue = 100;
  double endValue = 10000;

  RangeValues values = const RangeValues(100, 10000);
  int numberOfFound = 0;
  List<bool> _selected = List.generate(6, (index) => false);
  Result<List<Place>, Exception>? _placesData;

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
                  countPlaces();
                });
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 24, left: 16, bottom: 8, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.categories.toUpperCase(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              SelectedCategories(
                selected: _selected,
                child: CategoriesGrid(
                  _categories,
                  onPressed: () {
                    setState(countPlaces);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
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
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 16, right: 8),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    overlayShape: SliderComponentShape.noOverlay,
                  ),
                  child: RangeSlider(
                    min: 100,
                    max: 10000,
                    values: values,
                    divisions: 99,
                    onChangeEnd: (range) {
                      _getPlaces();
                    },
                    onChanged: (newRange) {
                      setState(() {
                        values = newRange;
                      });
                    },
                  ),
                ),
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

  int countPlaces() {
    numberOfFound = 0;
    _selected.forEachIndexed((index, selectedCategory) {
      if (selectedCategory) {
        final type = _categories[index].type;
        numberOfFound =
            numberOfFound + mocks.where((place) => place.type == type).length;
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

  void _getPlaces() {
    context
        .read<PlacesInteractor>()
        .getFilteredPlaces(
          minRadius: values.start,
          maxRadius: values.end,
        )
        .then((result) {
      setState(() {
        _placesData = result;
      });
    });
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
    final isHighResolution = MediaQuery.of(context).size.height *
            MediaQuery.of(context).devicePixelRatio >
        800;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: isHighResolution
          ? GridView.builder(
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
            )
          : SizedBox(
              height: 92,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget._categories.length,
                itemBuilder: (context, index) {
                  return CategoryItem(
                    widget._categories[index],
                    isSelected: selected[index],
                    onTap: () {
                      setState(() {
                        selected[index] = !selected[index];
                        widget.onPressed();
                      });
                    },
                  );
                },
              ),
            ),
    );
  }
}

/// Кнопка показать отфильтрованные места.
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
      title: text.isEmpty ? AppStrings.show.toUpperCase() : text,
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

/// Виджет для проброса количества выбранных мест вниз по дереву.
class CountButtonText extends InheritedWidget {
  final int count;

  String get title =>
      count != 0 ? '${AppStrings.show.toUpperCase()} ($count)' : '';

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
