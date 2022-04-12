import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

/// Логгирование.
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 100,
  ),
);

/// Слушатель изменения темы.
final themeNotifier = ChangeNotifier();