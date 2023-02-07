import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/json/json_map.dart';
import 'package:hmi_core/src/core/text_file.dart';
///
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
  static Future<void> initialize({TextFile? textFile}) async {
    if (textFile != null) {
      await AppUiSettingsNum._load(textFile);
    }
  }
  ///
  static Future<void> _load(TextFile textFile) {
    return JsonMap<num>.fromTextFile(textFile).decoded
      .then((map) => _map.addAll(map));
  }
  ///
  static num getSetting(String settingName) {
    final setting = _map[settingName];
    if (setting == null) {
      throw Failure(
        message: 'Ошибка в методе $AppUiSettingsNum.getSetting(): Не найдена настройка "$settingName"',
        stackTrace: StackTrace.current,
      );
    }
    return setting;
  }
}
