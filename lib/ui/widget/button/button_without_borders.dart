import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_colors.dart';

/// Кнопка с иконкой без фона.
class ButtonWithoutBorders extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final String? icon;
  final Color? color;

  const ButtonWithoutBorders({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.width,
    required this.height,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(width, height),
        alignment: Alignment.center,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            SvgPicture.asset(
              icon!,
              color: onPressed == null
                  ? AppColors.inactiveBlack
                  : color,
            ),
            const SizedBox(
              width: 10,
            ),
          ],
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: onPressed == null
                  ? AppColors.inactiveBlack
                  : color,
            ),
          ),
        ],
      ),
    );
  }
}
