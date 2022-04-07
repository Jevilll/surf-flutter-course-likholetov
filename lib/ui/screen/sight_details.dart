import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/image_preview.dart';

/// Экран детализиции достопримечательности.
class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 360,
            width: double.infinity,
            child: ImagePreview(
              imgUrl: sight.image,
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
            child: Text(
              sight.details,
              style: theme.textTheme.bodySmall,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 24, right: 16),
            height: 48,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: const Center(
              child: Text(
                AppStrings.buildARoute,
              ),
            ),
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
              children: const [
                ButtonWithText(AppStrings.toSchedule),
                ButtonWithText(AppStrings.toFavorites),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Заглушка в виде кнопки с текстом.
class ButtonWithText extends StatelessWidget {
  final String text;

  const ButtonWithText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(
          left: 16,
          top: 8,
          right: 16,
          bottom: 16,
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
