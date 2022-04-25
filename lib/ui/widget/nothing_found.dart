import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_colors.dart';

/// Виджет сообщения об отсутствии элементов в списке.
class NothingFound extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const NothingFound({
    required this.icon,
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color: AppColors.inactiveBlack,
          ),
          Text(
            title,
            style: theme.textTheme.titleMedium
                ?.copyWith(color: AppColors.inactiveBlack),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: AppColors.inactiveBlack),
          ),
        ],
      ),
    );
  }
}
