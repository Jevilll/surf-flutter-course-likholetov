import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/button/button_rounded.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:places/ui/widget/button/button_without_borders.dart';
import 'package:places/ui/widget/image_preview.dart';
import 'package:places/utils/common.dart';

/// Экран детализиции достопримечательности.
class SightDetails extends StatefulWidget {
  final Sight sight;

  const SightDetails(this.sight, {Key? key}) : super(key: key);

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  late final PageController _pageController;
  int indicatorsCount = 0;

  @override
  void initState() {
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

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            delegate: _GalleryDelegate(
              photos: widget.sight.images,
              controller: _pageController,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  width: double.infinity,
                  child: Text(
                    widget.sight.name,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, top: 2, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        widget.sight.type.name,
                        style: AppTextStyles.smallBold.copyWith(
                          color: theme.colorScheme.secondary2,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        widget.sight.workingHours,
                        style: AppTextStyles.small.copyWith(
                          color: theme.colorScheme.inactiveBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.sight.details,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
                ButtonRounded(
                  title: AppStrings.buildARoute,
                  onPressed: () {
                    logger.i('Нажатие на кнопку построить маршрут');
                  },
                  icon: AppIcons.go,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 24, right: 16),
                  height: 1,
                  width: double.infinity,
                  color: AppColors.inactiveBlack,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
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
                          logger.i('Нажатие на кнопку в избранное');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  @override
  double get maxExtent => 360;

  @override
  double get minExtent => 0;

  _GalleryDelegate({
    required this.photos,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: Stack(
        children: [
          PageView.builder(
            itemCount: photos.length,
            controller: controller,
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
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 36),
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ButtonSvgIcon(
                icon: AppIcons.arrow,
                color: Theme.of(context).colorScheme.main,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
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
