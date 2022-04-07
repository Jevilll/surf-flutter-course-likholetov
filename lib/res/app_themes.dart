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

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.secondary,
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
        titleLarge: AppTextStyles.largeTitle,
        titleMedium: AppTextStyles.title,
        titleSmall: AppTextStyles.subtitle,
        bodyLarge: AppTextStyles.text,
        bodyMedium: AppTextStyles.smallBold,
        bodySmall: AppTextStyles.small,
      ),
      cardTheme: _cartTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
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
        titleLarge: AppTextStyles.largeTitle.copyWith(color: AppColors.white),
        titleMedium: AppTextStyles.title.copyWith(color: AppColors.white),
        titleSmall: AppTextStyles.subtitle.copyWith(color: AppColors.white),
        bodyLarge: AppTextStyles.text.copyWith(color: AppColors.white),
        bodyMedium: AppTextStyles.smallBold.copyWith(color: AppColors.white),
        bodySmall: AppTextStyles.small.copyWith(color: AppColors.white),
      ),
      cardTheme: _cartTheme,
    );
  }
}

extension CustomColorScheme on ColorScheme {
  Color get white => AppColors.white;

  Color get secondary => AppColors.secondary;

  Color get secondary2 => AppColors.secondary2;

  Color get inactiveBlack => AppColors.inactiveBlack;

  Color get background => brightness == Brightness.light
      ? AppColors.lightBackground
      : AppColors.darkBackground;

  Color get green => brightness == Brightness.light
      ? AppColors.lightGreen
      : AppColors.darkGreen;
}
