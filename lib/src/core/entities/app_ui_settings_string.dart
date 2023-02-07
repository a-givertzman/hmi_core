import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/json/json_map.dart';
import 'package:hmi_core/src/core/text_file.dart';
///
class AppUiSettingsString {
  static final _map = <String, String>{};
  ///
  static Future<void> initialize({TextFile? textFile}) async {
    if (textFile != null) {
      await AppUiSettingsString._load(textFile);
    }
  }
  ///
  static Future<void> _load(TextFile textFile) {
    return JsonMap<String>.fromTextFile(textFile).decoded
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
