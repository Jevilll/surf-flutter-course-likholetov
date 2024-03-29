import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Кнопка svg иконки.
class ButtonSvgIcon extends StatelessWidget {
  final String icon;
  final Color? color;
  final VoidCallback? onPressed;

  const ButtonSvgIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      icon: SvgPicture.asset(
        icon,
        color: color,
      ),
      onPressed: onPressed,
    );
  }
}
