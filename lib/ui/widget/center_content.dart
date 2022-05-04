import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_colors.dart';

/// Виджет сообщения об отсутствии элементов в списке.
class CenterContent extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final Color? iconColor;

  const CenterContent({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor,
    this.titleStyle,
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
            color: iconColor ?? AppColors.inactiveBlack,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: titleStyle ??
                  theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.inactiveBlack),
            ),
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
