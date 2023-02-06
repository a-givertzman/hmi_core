import 'dart:convert';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/string_loader.dart';
///
class AppUiSettingsString {
}
class AppUiSettingsNum {
  static final _map = <String, num>{
    'displaySizeWidth': 1024,
    'displaySizeHeight': 768,
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
      .then((string) => const JsonCodec().decode(string) as Map<String, num>)
      .then((map) => _map.addAll(map));
  }
  ///
  static num getSetting(String key) {
    final setting = _map[key];
    if(setting == null) {
      throw Failure(
        message: 'Ошибка в методе $AppUiSettingsNum.getSetting(): Не найдена настройка "$key"',
        stackTrace: StackTrace.current,
      );
    }
    return setting;
  }
}