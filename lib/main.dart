import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/utils/common.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeData theme = AppThemes.lightTheme;

  @override
  Widget build(BuildContext context) {
    themeNotifier.addListener(() {
      setState(() {
        theme = theme.brightness == Brightness.light
            ? AppThemes.darkTheme
            : AppThemes.lightTheme;
      });
    });

    return MaterialApp(
      home: const SplashScreen(),
      theme: theme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
      ],
    );
  }
}
