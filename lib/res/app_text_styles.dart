import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';

abstract class AppTextStyles {
  static const largeTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
  );

  static const title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
  );

  static const subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
  );

  static const text = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    color: AppColors.whiteSecondary,
  );

  static const smallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    color: AppColors.white,
  );

  static const small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    color: AppColors.whiteSecondary2,
  );

  static const button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    letterSpacing: 0.03,
  );
}