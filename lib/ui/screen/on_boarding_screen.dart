import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/button/button_without_borders.dart';
import 'package:places/ui/widget/center_content.dart';

/// Экран онбординга.
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;

  final List<OnBoardingData> _pagesList = [
    OnBoardingData(
      title: AppStrings.slide1Title,
      subtitle: AppStrings.slide1Subtitle,
      icon: AppIcons.tutorial1,
    ),
    OnBoardingData(
      title: AppStrings.slide2Title,
      subtitle: AppStrings.slide2Subtitle,
      icon: AppIcons.tutorial2,
    ),
    OnBoardingData(
      title: AppStrings.slide3Title,
      subtitle: AppStrings.slide3Subtitle,
      icon: AppIcons.tutorial3,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ButtonWithoutBorders(
              title: AppStrings.skip,
              height: 32,
              width: 82,
              color: theme.colorScheme.green,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            itemCount: _pagesList.length,
            itemBuilder: (context, position) {
              return CenterContent(
                icon: _pagesList[position].icon,
                iconColor: theme.colorScheme.main,
                title: _pagesList[position].title,
                titleStyle: theme.textTheme.titleMedium,
                subtitle: _pagesList[position].subtitle,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 88),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: DotsIndicator(
                controller: _pageController,
                itemCount: _pagesList.length,
                activeItemColor: theme.colorScheme.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Модель данных экрана онбординга.
class OnBoardingData {
  String title;
  String subtitle;
  String icon;

  OnBoardingData({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

/// Анимированный виджет индикатора.
class DotsIndicator extends AnimatedWidget {
  static const double _dotSize = 8.0;
  static const double _maxZoom = 3.0;

  final PageController controller;
  final int itemCount;
  final Color activeItemColor;

  const DotsIndicator({
    Key? key,
    required this.controller,
    required this.itemCount,
    required this.activeItemColor,
  }) : super(key: key, listenable: controller);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }

  Widget _buildDot(int index) {
    final value = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    final zoom = 1.0 + (_maxZoom - 1.0) * value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: _dotSize,
        width: _dotSize * zoom,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorTween(begin: AppColors.inactiveBlack, end: activeItemColor)
              .evaluate(AlwaysStoppedAnimation(value)),
        ),
      ),
    );
  }
}
