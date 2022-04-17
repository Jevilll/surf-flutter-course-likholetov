import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_themes.dart';

/// Кнопка с иконкой без фона.
class ButtonRounded extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color? color;
  final String? icon;

  const ButtonRounded({
    Key? key,
    required this.title,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 48,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(left: 16, top: 24, right: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(width, height),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          primary: onPressed != null ? color ?? theme.colorScheme.green : theme.colorScheme.disabledButton,
          // onSurface: Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(
                icon!,
                color: AppColors.white,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: onPressed != null ? AppColors.white : AppColors.inactiveBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
