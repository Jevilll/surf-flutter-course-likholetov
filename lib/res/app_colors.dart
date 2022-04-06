import 'package:flutter/material.dart';

abstract class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF3B3E5B);
  static const secondary2 = Color(0xFF7C7E92);
  static const inactiveBlack = Color(0x8F7C7E92);
}

abstract class AppColorsLight {
  static const background = Color(0xFFF5F5F5);
  static const green = Color(0xFF4CAF50);
  static const yellow = Color(0xFFFBC02D);
  static const red = Color(0xFFEF4343);
  static const main = Color(0xFF252849);
}

abstract class AppColorsDark {
  static const background = dark;
  static const green = Color(0xFF71D675);
  static const yellow = Color(0xFFFFEA7E);
  static const red = Color(0xFFCF2A2A);
  static const dark = Color(0xFF1A1A20);
  static const main = Color(0xFF21222C);
}