import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/ui/screen/home_page.dart';
import 'package:places/utils/common.dart';

/// Экран сплеша, перенаправляет в [HomePage] после ожидания самого долгого
/// из событий инициализации приложения/константной задержки сплеша.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Future<void> isInitialized;
  late final Future<void> isSplashDelayed;

  @override
  void initState() {
    isInitialized = _waitInit();
    isSplashDelayed = _waitSplash();

    _navigateToNext();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.fabGreen,
            AppColors.lightGreen,
          ],
          begin: Alignment(-1.8, 0.0),
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          AppIcons.mapRounded,
          color: AppColors.white,
        ),
      ),
    );
  }

  Future<void> _waitInit() async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
      () => logger.w('init done'),
    );
  }

  Future<void> _waitSplash() async {
    await Future<void>.delayed(
      const Duration(seconds: 2),
      () => logger.w('splash delay done'),
    );
  }

  Future<void> _navigateToNext() async {
    await Future.wait<void>([isInitialized, isSplashDelayed]);

    if (!mounted) return;

    unawaited(Navigator.pushReplacement(
      context,
      MaterialPageRoute<HomePage>(
        builder: <BuildContext>(context) => const HomePage(),
      ),
    ));
  }
}
