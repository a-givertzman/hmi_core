import 'dart:convert';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/string_loader.dart';
///
class AppUiSettings {
  static final _map = <String, dynamic>{
    'displaySize': {
      'width': 1024,
      'height': 768,
    },
    // Place Durations in milliseconds!
    'flushBarDurationLong': 8000,
    'flushBarDurationMedium': 4000,
    'flushBarDurationShort': 2000,
    'padding': 8.0,
    'blockPadding': 16.0,
    'floatingActionButtonSize': 60.0,
    'floatingActionIconSize': 45.0,
  };
  ///
  static Future<void> load(StringLoader stringLoader) {
    return stringLoader.load()
      .then((string) => const JsonCodec().decode(string) as Map<String, dynamic>)
      .then((map) => _map.addAll(map));
  }
  ///
  static List<String> getSetting(String key) {
    final setting = _map[key];
    if(setting == null) {
      throw Failure(
        message: 'Ошибка в методе $AppUiSettings.getSetting(): Не найдена настройка "$key"',
        stackTrace: StackTrace.current,
      );
    }
    return setting;
  }
}