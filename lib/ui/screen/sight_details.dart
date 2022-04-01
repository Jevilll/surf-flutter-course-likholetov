import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_text_styles.dart';

/// Экран детализиции достопримечательности.
class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 360,
            width: double.infinity,
            child: Image.network(
              sight.image,
              fit: BoxFit.cover,
              loadingBuilder: (
                  context,
                  child,
                  loadingProgress,
                  ) {
                if (loadingProgress == null) {
                  return child;
                }

                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
            width: double.infinity,
            child: Text(
              sight.name,
              style: AppTextStyles.title,
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
                  style: AppTextStyles.text,
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  'закрыто до 09:00', // TODO(Jevil): заглушка для дизайна
                  style: AppTextStyles.small,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
            child: Text(
              sight.details,
              style: AppTextStyles.small,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 24, right: 16),
            height: 48,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.whiteGreen,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: const Center(
              child: Text(
                'Построить маршрут',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 24, right: 16),
            height: 1,
            width: double.infinity,
            color: AppColors.whiteInactiveBlack,
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
          left: 16, top: 8, right: 16, bottom: 16,),
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

