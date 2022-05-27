import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_themes.dart';

/// Виджет градиентного прогресса.
class GradientProgress extends StatelessWidget {
  const GradientProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientProgressIndicator(
      radius: 20,
      gradientColors: [
        AppColors.secondary2,
        theme.colorScheme.inactive,
      ],
      gradientStops: const [
        0.2,
        0.8,
      ],
      duration: 1,
      strokeWidth: 4,
      child: const SizedBox(),
    );
  }
}
