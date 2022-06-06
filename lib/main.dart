import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/data/repository/location_repository_impl.dart';
import 'package:places/data/repository/places_repository_impl.dart';
import 'package:places/domain/interactor/places_interactor.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
import 'package:places/domain/repository/location_repository.dart';
import 'package:places/domain/repository/places_repository.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/store/place_list_store.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/utils/common.dart';
import 'package:provider/provider.dart';

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

    return MultiProvider(
      providers: [
        Provider<PlacesRepository>(create: (context) => PlacesRepositoryImpl()),
        Provider<LocationRepository>(
          create: (context) => LocationRepositoryImpl(),
        ),
        Provider<PlacesInteractor>(
          create: (context) => PlacesInteractor(
            context.read<PlacesRepository>(),
            context.read<LocationRepository>(),
          ),
          dispose: (context, interactor) {
            interactor.dispose();
          },
        ),
        Provider<SearchInteractor>(
          create: (context) => SearchInteractor(
            context.read<PlacesRepository>(),
          ),
        ),
        Provider<SettingsInteractor>(create: (context) => SettingsInteractor()),
        Provider<PlaceListStore>(
          create: (context) => PlaceListStore(context.read<PlacesRepository>()),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
