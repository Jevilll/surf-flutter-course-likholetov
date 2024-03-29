import 'package:flutter/material.dart';
import 'package:places/domain/interactor/places_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/result.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/button/button_rounded.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:places/ui/widget/button/button_without_borders.dart';
import 'package:places/ui/widget/image_preview.dart';
import 'package:places/ui/widget/progress.dart';
import 'package:places/utils/common.dart';
import 'package:provider/provider.dart';

/// Команда показать [BottomSheet] детализации места.
void showDetails(int id, BuildContext context) {
  showModalBottomSheet<_PlaceDetails>(
    context: context,
    builder: (context) {
      return _PlaceDetails(id);
    },
    isScrollControlled: true,
  );
}

/// [BottomSheet] детализиции места.
class _PlaceDetails extends StatefulWidget {
  final int id;

  const _PlaceDetails(this.id, {Key? key}) : super(key: key);

  @override
  State<_PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<_PlaceDetails> {
  late final PageController _pageController;
  final _bottomSheetSize = 0.9;
  int indicatorsCount = 0;
  Result<Place, Exception>? _placeData;

  @override
  void initState() {
    context.read<PlacesInteractor>().getPlace(id: widget.id).then((result) {
      setState(() {
        _placeData = result;
      });
    });
    _pageController = PageController();
    _pageController.addListener(() => setState(() {
          indicatorsCount = _pageController.page?.toInt() ?? 0;
        }));
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: _bottomSheetSize,
      maxChildSize: _bottomSheetSize,
      builder: (context, scrollController) {
        return _placeData != null
            ? _placeData!.when(
                success: (place) {
                  return CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverPersistentHeader(
                        delegate: _GalleryDelegate(
                          photos: place.urls,
                          controller: _pageController,
                          scrollController: scrollController,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          color: theme.colorScheme.background2,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 16,
                                  right: 16,
                                ),
                                width: double.infinity,
                                child: Text(
                                  place.name,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 2,
                                  right: 16,
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      place.type.name,
                                      style: AppTextStyles.smallBold.copyWith(
                                        color: theme.colorScheme.secondary2,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      place.workingHours,
                                      style: AppTextStyles.small.copyWith(
                                        color: theme.colorScheme.inactiveBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(minHeight: 76),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    top: 24,
                                    right: 16,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      place.description,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                ),
                              ),
                              ButtonRounded(
                                title: AppStrings.buildARoute.toUpperCase(),
                                onPressed: () {
                                  logger
                                      .i('Нажатие на кнопку построить маршрут');
                                },
                                icon: AppIcons.go,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 16,
                                  top: 24,
                                  right: 16,
                                ),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 16,
                                  top: 8,
                                  right: 16,
                                ),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonWithoutBorders(
                                      title: AppStrings.toSchedule,
                                      icon: AppIcons.calendar,
                                      height: 40,
                                      width: 164,
                                      color: Theme.of(context).colorScheme.text,
                                      onPressed: null,
                                    ),
                                    ButtonWithoutBorders(
                                      title: AppStrings.toFavorites,
                                      icon: AppIcons.heart,
                                      height: 40,
                                      width: 164,
                                      color: Theme.of(context).colorScheme.text,
                                      onPressed: () {
                                        logger
                                            .i('Нажатие на кнопку в избранное');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                failure: (failure) {
                  return const Center(child: Text('ошибка'));
                },
              )
            : const Center(child: GradientProgress());
      },
    );
  }
}

/// Виджет индикатора.
class _PageIndicator extends StatelessWidget {
  final PageController controller;
  final int pageCount;

  const _PageIndicator({
    Key? key,
    required this.controller,
    required this.pageCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) => FractionallySizedBox(
        alignment: Alignment.bottomLeft,
        widthFactor: ((controller.page ?? 0) + 1) / pageCount,
        child: child,
      ),
      child: SizedBox(
        height: 8,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(8.0)),
            border: Border.all(color: AppColors.inactiveBlack),
            color: AppColors.lightMain,
          ),
        ),
      ),
    );
  }
}

/// Делегат сворачиваемого сливера галереи.
class _GalleryDelegate extends SliverPersistentHeaderDelegate {
  final List<String> photos;
  final PageController controller;
  final ScrollController scrollController;

  @override
  double get maxExtent => 360;

  @override
  double get minExtent => 0;

  _GalleryDelegate({
    required this.photos,
    required this.controller,
    required this.scrollController,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Material(
        child: Stack(
          children: [
            PageView.builder(
              itemCount: photos.length,
              controller: controller,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, position) {
                return ImagePreview(
                  imgUrl: photos[position],
                );
              },
            ),
            if (photos.length > 1)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: _PageIndicator(
                    controller: controller,
                    pageCount: photos.length,
                  ),
                ),
              ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                height: 4,
                width: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppColors.white,
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: ButtonSvgIcon(
                icon: AppIcons.cardClose,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! _GalleryDelegate ||
        minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxExtent ||
        snapConfiguration != oldDelegate.snapConfiguration ||
        photos != oldDelegate.photos ||
        controller != oldDelegate.controller;
  }
}
