import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/interactor/places_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/center_content.dart';
import 'package:places/ui/widget/place_card.dart';
import 'package:provider/provider.dart';

/// Экран избранных мест.
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final PlacesInteractor _placesInteractor;
  late final List<Place> _favoritesData;
  late final List<Place> _visitedData;

  @override
  void initState() {
    _placesInteractor = context.read<PlacesInteractor>();
    _favoritesData = _placesInteractor.getFavorites();
    _visitedData = _placesInteractor.getVisited();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomAppBar(title: AppStrings.favorites),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: theme.cardColor,
            ),
            child: const TabBar(
              tabs: [
                Tab(
                  text: AppStrings.wantToVisit,
                ),
                Tab(
                  text: AppStrings.visited,
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                ReorderableDismissibleList(
                  places: _favoritesData,
                  type: CardType.toVisit,
                ),
                ReorderableDismissibleList(
                  places: _visitedData,
                  type: CardType.visited,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

/// Сортируемый список мест, с возможностью удалить элемент путем смахивания.
class ReorderableDismissibleList extends StatefulWidget {
  final List<Place> places;
  final CardType type;

  const ReorderableDismissibleList({
    required this.places,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  State<ReorderableDismissibleList> createState() =>
      _ReorderableDismissibleListState();
}

class _ReorderableDismissibleListState
    extends State<ReorderableDismissibleList> {
  late final PlacesInteractor _placesInteractor;
  late final CardType _type;

  @override
  void initState() {
    _placesInteractor = context.read<PlacesInteractor>();
    _type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return widget.places.isNotEmpty
        ? ReorderableListView.builder(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: widget.places.length,
            itemBuilder: (context, index) {
              final place = widget.places[index];

              return Padding(
                key: ObjectKey(place),
                padding: const EdgeInsets.only(bottom: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    key: ObjectKey(place),
                    background: const DeleteBackground(),
                    onDismissed: (_) {
                      setState(() {
                        _removeFavorite(place);
                      });
                    },
                    child: Container(
                      color: theme.colorScheme.red,
                      child: PlaceCard(
                        place,
                        type: _type,
                        onDelete: () {
                          setState(() {
                            _removeFavorite(place);
                          });
                        },
                        onDatePick: _putRemainder,
                      ),
                    ),
                  ),
                ),
              );
            },
            onReorder: _reorderData,
          )
        : CenterContent(
            icon: AppIcons.card64,
            title: AppStrings.empty,
            subtitle: _type == CardType.toVisit
                ? AppStrings.emptyToVisit
                : AppStrings.emptyVisited,
          );
  }

  void _removeFavorite(Place place) {
    setState(() {
      widget.places.remove(place);
      _placesInteractor.removeFromFavorites(place);
    });
  }

  void _reorderData(int oldItem, int newItem) {
    setState(() {
      final items = widget.places.removeAt(oldItem);
      widget.places.insert(newItem > oldItem ? newItem - 1 : newItem, items);
    });
  }

  Future<void> _putRemainder() async {
    final now = DateTime.now();
    DateTime? selectedDateTime = null;
    if (Platform.isAndroid) {
      final dateResult = await showDatePicker(
        context: context,
        locale: const Locale("ru", "RU"),
        helpText: AppStrings.chooseDateOfVisit,
        confirmText: AppStrings.chooseTime,
        cancelText: AppStrings.cancel2,
        initialDate: now,
        firstDate: now,
        lastDate: now.add(const Duration(days: 360)),
      );
      if (dateResult != null) {
        final timeResult = await showTimePicker(
          context: context,
          helpText: AppStrings.chooseTimeOfVisit,
          cancelText: AppStrings.cancel2,
          confirmText: AppStrings.plan,
          initialTime: TimeOfDay.now(),
        );
        if (timeResult != null) {
          selectedDateTime = DateTime(
            dateResult.year,
            dateResult.month,
            dateResult.day,
            timeResult.hour,
            timeResult.minute,
          );
        }
      }
    } else {
      await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (_) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              onDateTimeChanged: (value) {
                selectedDateTime = value;
              },
              initialDateTime: DateTime.now(),
              minimumYear: now.year,
              maximumYear: now.year + 1,
            ),
          );
        },
      );
    }
  }
}

/// Виджет заднего фона смахиваемого элемента.
class DeleteBackground extends StatelessWidget {
  const DeleteBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.red,
        border: Border.all(
          color: theme.colorScheme.red,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: UnconstrainedBox(
          child: Column(
            children: [
              SvgPicture.asset(
                AppIcons.bucket,
                color: AppColors.white,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                AppStrings.remove,
                style:
                    theme.textTheme.bodySmall?.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
