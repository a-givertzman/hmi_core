import 'dart:convert';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/json/json_map.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/hmi_core_text_file.dart';
import 'package:hmi_core/src/core/result/result_transform_extension.dart';
///
/// Stores application settings.
///
/// Settings can be accessed for reading and writing by its keys.
///
/// For key names prefer to use kebab-case notation, with unique prefixes
/// for different groups of settings. E.g. `ui-padding`, `ui-font-size`,
/// `api-host`, `api-port`, etc.
class AppSettings {
  static const _log = Log('AppSettings ');
  static final _settings = <String, dynamic>{
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
  static final _isWritable = <String, bool>{};
  static TextFile _store = const TextFile.path('stored_settings.json');
  ///
  /// Initializes app settings with [readOnly] and [writable] settings.
  ///
  /// [readOnly] settings are accessible for reading only.
  ///
  /// [writable] settings are accessible for reading and updating (writing).
  ///
  /// [store] file is used to write and restore [writable] settings.
  /// If not passed, file with path `stored_settings.json` will be used
  /// by default.
  static Future<void> initialize({
    JsonMap<dynamic> readOnly = const JsonMap.empty(),
    JsonMap<dynamic> writable = const JsonMap.empty(),
    TextFile? store,
  }) async {
    if (store != null) {
      _store = store;
    }
    _log.info('Initializing read-only app settings...');
    await _parseSettings(
      readOnly,
      onSettingParsed: (entry) {
        if (_settings.containsKey(entry.key)) {
          _log.warning('Setting with key "${entry.key}" will be overwritten.');
        }
        _settings[entry.key] = entry.value;
        _isWritable[entry.key] = false;
        _log.info('Added read-only setting "${entry.key}": ${entry.value}...');
      },
    );
    _log.info('Initializing writable app settings...');
    await _parseSettings(
      writable,
      onSettingParsed: (entry) {
        if (_settings.containsKey(entry.key)) {
          _log.warning(
            'Setting with key "${entry.key}" was overwritten.',
          );
        }
        _settings[entry.key] = entry.value;
        _isWritable[entry.key] = true;
        _log.info('Added writeable setting "${entry.key}": ${entry.value}...');
      },
    );
    _log.info('Restoring writable app settings...');
    await _parseSettings(
      JsonMap.fromTextFile(_store),
      onSettingParsed: (entry) {
        if (!_canWriteSetting(entry.key)) {
          _log.warning('Writeable setting with key "${entry.key}" does not exist and was ignored.');
        } else {
          _settings[entry.key] = entry.value;
          _log.info('Restored writeable setting "${entry.key}": ${entry.value}...');
        }
      },
    );
  }
  //
  static Future<void> _parseSettings(
    JsonMap<dynamic> settings, {
    void Function(MapEntry<String, dynamic>)? onSettingParsed,
  }) async {
    final decodedResult = await settings.decoded;
    decodedResult.inspect((map) {
      for (final entry in map.entries) {
        onSettingParsed?.call(entry);
      }
    }).inspectErr((error) {
      _log.warning('Failed to initialize app settings, ${error.message}.');
    });
  }
  //
  static bool _canWriteSetting(String key) {
    return _settings.containsKey(key) && _isWritable.containsKey(key) && (_isWritable[key] ?? false);
  }
  ///
  /// Returns value of app setting by [key].
  ///
  /// Calls [onError] that can return other value based on passed [Failure].
  static dynamic getSetting(
    String key, {
    dynamic Function(Failure err)? onError,
  }) {
    if (!_settings.containsKey(key)) {
      final err = Failure(
        message: '$AppSettings.getSetting | Not found key "$key"',
        stackTrace: StackTrace.current,
      );
      if (onError != null) {
        return onError(err);
      } else {
        throw err;
      }
    }
    return _settings[key];
  }
  ///
  /// Returns map of writable settings.
  ///
  /// Gets entries from [_store] if it exists,
  /// otherwise gets writable entries from [_settings].
  static Future<Map<String, dynamic>> _getWritableSettings() async {
    final mapResult = await JsonMap.fromTextFile(_store).decoded;
    return mapResult.mapOrElse(
      (_) {
        return Map.fromEntries(
          _settings.entries.where(
            (entry) => _isWritable.containsKey(entry.key),
          ),
        );
      },
      (map) {
        return map;
      },
    );
  }
  ///
  /// Immediately updates app setting with key [settingName] to new [value]
  /// and save it asynchronously to file.
  ///
  /// Calls [onSuccess] or [onError] when setting will be saved successfully
  /// or with error. In case of error returns app setting to its previous value.
  static Future<void> setSetting(
    String settingName,
    dynamic value, {
    void Function(Failure error)? onError,
    void Function()? onSuccess,
  }) async {
    if (!_canWriteSetting(settingName)) {
      final failure = Failure(
        message: 'Cannot update setting with key "$settingName".',
        stackTrace: StackTrace.current,
      );
      onError?.call(failure);
    } else {
      final valueBackup = _settings[settingName];
      _settings[settingName] = value;
      final storedMap = await _getWritableSettings();
      storedMap[settingName] = value;
      await _store
        .write(json.encode(storedMap)).then(
          (_) {
            onSuccess?.call();
          },
        ).catchError(
          (error, stackTrace) {
            final failure = Failure(
              message: 'Failed to save setting "$settingName", $error.',
              stackTrace: stackTrace,
            );
            _log.warning(failure.message);
            _settings[settingName] = valueBackup;
            onError?.call(failure);
          },
        );
    }
  }
}
