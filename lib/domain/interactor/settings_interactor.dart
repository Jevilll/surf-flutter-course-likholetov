import 'package:places/utils/common.dart';

/// Интерактор для работы с настройками.
class SettingsInteractor {

  /// Переключить тему приложения.
  void switchTheme() {
    themeNotifier.notifyListeners();
  }
}