import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/json/json_map.dart';
///
class AppUiSettingsString {
  static final _map = <String, String>{};
  ///
  static Future<void> initialize({JsonMap<String>? jsonMap}) async {
    if (jsonMap != null) {
      await jsonMap.decoded
        .then((map) => _map.addAll(map));
    }
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
