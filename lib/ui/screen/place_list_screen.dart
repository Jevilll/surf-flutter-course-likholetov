import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/interactor/places_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/result.dart';
import 'package:places/presentation/model/ui_state.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/screen/add_place_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/place_search_screen.dart';
import 'package:places/ui/widget/place_card.dart';
import 'package:places/ui/widget/progress.dart';
import 'package:places/ui/widget/search_bar.dart';

typedef OperationResult = Result<List<Place>, Exception>;

/// Экран списка мест.
class PlaceListScreen extends StatefulWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  State<PlaceListScreen> createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  final _placesStreamController =
      StreamController<UiState<OperationResult>>();

  @override
  void initState() {
    placesInteractor.placesStream.listen((result) {
      _placesStreamController.add(UiState.result(result));
    });

    placesInteractor.getPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: isPortrait ? 140 : 56,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: isPortrait
                  ? const EdgeInsets.all(16)
                  : const EdgeInsets.only(
                      left: 34,
                      top: 16,
                      right: 34,
                      bottom: 16,
                    ),
              expandedTitleScale: 1.8,
              centerTitle: isPortrait,
              title: Text(
                AppStrings.listOfInterestingPlacesTwoLines,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: isPortrait
                  ? const EdgeInsets.only(bottom: 16)
                  : const EdgeInsets.only(left: 18, right: 18, bottom: 16),
              child: SearchBar(
                isReadOnly: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<PlaceSearchScreen>(
                      builder: <BuildContext>(context) =>
                          const PlaceSearchScreen(),
                    ),
                  );
                },
                suffix: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<FiltersScreen>(
                        builder: <BuildContext>(context) =>
                            const FiltersScreen(),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    AppIcons.filter,
                    color: theme.colorScheme.green,
                  ),
                ),
              ),
            ),
          ),
          _PlacesList(
            placesStreamController: _placesStreamController,
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 48,
        width: 177,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [AppColors.fabGreen, AppColors.darkGreen],
          ),
        ),
        child: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute<AddPlaceScreen>(
                builder: <BuildContext>(context) => const AddPlaceScreen(),
              ),
            );
            setState(() {});
          },
          label: const Text(AppStrings.newPlace),
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: SvgPicture.asset(
            AppIcons.plus,
            color: AppColors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    _placesStreamController.close();
    super.dispose();
  }
}

class _PlacesList extends StatefulWidget {
  final StreamController<UiState<OperationResult>> placesStreamController;

  const _PlacesList({required this.placesStreamController, Key? key})
      : super(key: key);

  @override
  State<_PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends State<_PlacesList> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder(
      stream: widget.placesStreamController.stream,
      initialData: const UiState<OperationResult>.loading(),
      builder: (context, snapShot) {
        return (snapShot.data as UiState<OperationResult>).when(
          result: (result) {
            return result.when(
              success: (places) {
                return SliverPadding(
                  padding: isPortrait
                      ? const EdgeInsets.only(left: 16, top: 16, right: 16)
                      : const EdgeInsets.only(left: 34, top: 16, right: 34),
                  sliver: isPortrait
                      ? _PlacesListPortrait(
                          places: places,
                        )
                      : _PlacesListLandscape(
                          places: places,
                        ),
                );
              },
              failure: (failure) {
                return const SliverToBoxAdapter(
                  child: Center(child: Text('ошибка')),
                );
              },
            );
          },
          loading: () {
            return const SliverToBoxAdapter(
              child: Center(child: GradientProgress()),
            );
          },
        );
      },
    );
  }
}

/// Список мест при портретной ориентации.
class _PlacesListPortrait extends StatefulWidget {
  final List<Place> places;

  const _PlacesListPortrait({required this.places, Key? key}) : super(key: key);

  @override
  State<_PlacesListPortrait> createState() => _PlacesListPortraitState();
}

class _PlacesListPortraitState extends State<_PlacesListPortrait> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final place = widget.places[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PlaceCard(
              place,
              onFavorite: () {
                if (place.isFavorite) {
                  placesInteractor.removeFromFavorites(place);
                } else {
                  placesInteractor.addToFavorites(place);
                }
              },
            ),
          );
        },
        childCount: widget.places.length,
      ),
    );
  }
}

/// Список мест при альбомной ориентации.
class _PlacesListLandscape extends StatelessWidget {
  final List<Place> places;

  const _PlacesListLandscape({required this.places, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PlaceCard(
              places[index],
            ),
          );
        },
        childCount: places.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 36,
      ),
    );
  }
}
