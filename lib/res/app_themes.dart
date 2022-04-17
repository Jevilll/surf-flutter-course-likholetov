import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_sizes.dart';
import 'package:places/res/app_text_styles.dart';

class AppThemes {
  static const _appBarTheme = AppBarTheme(
    elevation: 0,
  );

  static const _bottomNavThemeData = BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  );

  static const _tabBarTheme = TabBarTheme(
    labelStyle: AppTextStyles.smallBold,
    unselectedLabelColor: AppColors.inactiveBlack,
  );

  static final _cartTheme = CardTheme(
    clipBehavior: Clip.hardEdge,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
    ),
  );

  static final _sliderTheme = ThemeData.light().sliderTheme.copyWith(
        trackHeight: 1,
        inactiveTrackColor: AppColors.inactiveBlack,
        thumbColor: AppColors.white,
      );

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.secondary,
      splashColor: AppColors.inactiveBlack,
      cardColor: AppColors.lightBackground,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: _appBarTheme.copyWith(
        backgroundColor: AppColors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      bottomNavigationBarTheme: _bottomNavThemeData.copyWith(
        backgroundColor: AppColors.lightBackground,
      ),
      tabBarTheme: _tabBarTheme.copyWith(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.tabBarRadius),
          color: AppColors.secondary,
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: AppTextStyles.title,
        titleMedium: AppTextStyles.subtitle,
        titleSmall: AppTextStyles.superSmall,
        bodyLarge: AppTextStyles.text,
        bodyMedium: AppTextStyles.smallBold,
        bodySmall: AppTextStyles.small,
      ),
      cardTheme: _cartTheme,
      sliderTheme: _sliderTheme.copyWith(
        activeTrackColor: AppColors.lightGreen,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      splashColor: AppColors.inactiveBlack,
      primaryColor: AppColors.white,
      cardColor: AppColors.darkBlack,
      scaffoldBackgroundColor: AppColors.darkMain,
      appBarTheme: _appBarTheme.copyWith(
        backgroundColor: AppColors.darkMain,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      bottomNavigationBarTheme: _bottomNavThemeData.copyWith(
        backgroundColor: AppColors.darkBackground,
      ),
      tabBarTheme: _tabBarTheme.copyWith(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.tabBarRadius),
          color: AppColors.white,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: AppTextStyles.title.copyWith(color: AppColors.white),
        titleMedium: AppTextStyles.subtitle.copyWith(color: AppColors.white),
        titleSmall: AppTextStyles.subtitle.copyWith(color: AppColors.white),
        bodyLarge: AppTextStyles.text.copyWith(color: AppColors.white),
        bodyMedium: AppTextStyles.smallBold.copyWith(color: AppColors.white),
        bodySmall: AppTextStyles.small.copyWith(color: AppColors.white),
      ),
      cardTheme: _cartTheme,
      sliderTheme: _sliderTheme.copyWith(
        activeTrackColor: AppColors.darkGreen,
      ),
    );
  }
}

extension CustomColorScheme on ColorScheme {
  Color get white => AppColors.white;

  Color get secondary1 => AppColors.secondary;

  Color get secondary2 => AppColors.secondary2;

  Color get inactiveBlack => AppColors.inactiveBlack;

  Color get text =>
      brightness == Brightness.light ? AppColors.secondary : AppColors.white;

  Color get background => brightness == Brightness.light
      ? AppColors.lightBackground
      : AppColors.darkBackground;

  Color get green => brightness == Brightness.light
      ? AppColors.lightGreen
      : AppColors.darkGreen;

  Color get main =>
      brightness == Brightness.light ? AppColors.lightMain : AppColors.white;

  Color get mainInverse =>
      brightness == Brightness.light ? AppColors.white : AppColors.lightMain;

  Color get disabledButton =>
      brightness == Brightness.light ? AppColors.lightBackground : AppColors.darkBlack;
}
