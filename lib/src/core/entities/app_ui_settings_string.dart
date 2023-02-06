import 'dart:convert';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/string_loader.dart';

class AppUiSettingsString {
  static final _map = <String, String>{};
  ///
  static Future<void> initialize({StringLoader? stringLoader}) async {
    if (stringLoader != null) {
      await AppUiSettingsString._load(stringLoader);
    }
  }
  ///
  static Future<void> _load(StringLoader stringLoader) {
    return stringLoader.load()
      .then((string) => const JsonCodec().decode(string) as Map<String, dynamic>)
      .then((map) => map.cast<String, String>())
      .then((map) => _map.addAll(map));
  }
  ///
  static String getSetting(String settingName) {
    final setting = _map[settingName];
    if (setting == null) {
      throw Failure(
        message: 'Ошибка в методе $AppUiSettingsString.getSetting(): Не найдена настройка "$settingName"',
        stackTrace: StackTrace.current,
      );
    }
    return setting;
  }
}
