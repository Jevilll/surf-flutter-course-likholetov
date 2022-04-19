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
class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          Material(
            child: Stack(
              children: [
                SizedBox(
                  height: 360,
                  width: double.infinity,
                  child: ImagePreview(
                    imgUrl: sight.image,
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
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
            width: double.infinity,
            child: Text(
              sight.name,
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
                  sight.type.name,
                  style: AppTextStyles.smallBold.copyWith(
                    color: theme.colorScheme.secondary2,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  sight.workingHours,
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
                sight.details,
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
    );
  }
}