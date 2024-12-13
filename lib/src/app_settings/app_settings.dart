import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/json/json_map.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/result/result.dart';
///
class AppSettings {
  static const _log = Log('AppSettings');
  static final _map = <String, dynamic>{
    'displaySizeWidth': 1024,
    'displaySizeHeight': 768,
    // Place Durations in milliseconds!
    'flushBarDurationLong': 8000,
    'flushBarDurationMedium': 4000,
    'flushBarDurationShort': 2000,
    'smallPadding': 4.0,
    'padding': 8.0,
    'blockPadding': 16.0,
    'floatingActionButtonSize': 60.0,
    'floatingActionIconSize': 45.0,
  };
  ///
  static Future<void> initialize({JsonMap<dynamic>? jsonMap}) async {
    if (jsonMap != null) {
      await jsonMap.decoded
        .then((result) => switch(result) {
          Ok(value: final map) => _map.addAll(map),
          Err(: final error) => _log.warning('$AppSettings.initialize | Failed to initialize app settings from file. Error: $error'),
        });
    }
  }
  ///
  /// Returns stored value by it's key
  static dynamic getSetting(String key, {dynamic Function(Failure err)? onError}) {
    final setting = _map[key];
    if (setting == null) {
      final err = Failure(
        message: '$AppSettings.getSetting | Not found key "$key"',
        stackTrace: StackTrace.current,
      );
      if (onError != null) {
        return onError(err);
      }
      throw err;
    }
    return setting;
  }
}
