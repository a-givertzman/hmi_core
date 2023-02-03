import 'dart:convert';

import 'package:hmi_core/hmi_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Класс реализует чтение и запись данных
/// простых типов в локальное хранилище
/// так же поддерживает шифрование данных 
/// в юникод utf8 и затем в base64 string 
class LocalStore {
  static const _debug = false;
  LocalStore();
  Future<SharedPreferences> _getPrefs() {
    return SharedPreferences
      .getInstance()
      .then(
        (prefs) => prefs,
      );
  }
  /// Метод вернет строку как есть (без расшифровки) из localStore
  Future<String> readString(String key) {
    return _getPrefs().then((prefs) {
      final value = prefs.getString(key) ?? '';
      log(_debug, '[LocalStore.readRawString] key: $key;\tfound value: $value');
      return value;
    });
  }
  /// Метод сохранит строку как есть (без шифрования) в localStore
  Future<bool> writeString(String key, String value) {
    return _getPrefs().then((prefs) {
      return prefs.setString(key, value).then((result) {
        log(_debug, '[LocalStore.writeRawString] key: $key;\twritten value: $value');
        return result;
      });
    });
  }
  /// Метод вернет строку с расшифровкой из localStore
  Future<String> readStringDecoded(String key) {
    return _getPrefs().then((prefs) {
      final value = prefs.getString(key) ?? '';
      log(_debug, '[LocalStore.readString] key: $key;\tvalue: $value');
      return decodeStr(value);
    });
  }
  /// Метод сохранит строку с шифрованем в localStore
  Future<bool> writeStringEncoded(String key, String value) {
    return _getPrefs().then((prefs) {
      return prefs.setString(key, encodeStr(value)).then((value) {
        log(_debug, '[LocalStore.writeString] key: $key;\tvalue: $value');
        return value;
      });
    });
  }
  Future<bool> clear() {
    return _getPrefs().then((prefs) {
      return prefs.clear().then((value) {
        log(_debug, '[LocalStore.clear] deleted all keys');
        return value;
      });
    });
  }
  Future<bool> remove(String key) {
    return _getPrefs().then((prefs) {
      return prefs.remove(key).then((value) {
        log(_debug, '[LocalStore.remove] deleted key: $key');
        return value;
      });
    });
  }
  String encodeStr(String value) {
    final bytes = utf8.encode(value);
    final base64Str = base64.encode(bytes);
    log(_debug, '[LocalStore.encodeStr] str: $value to $base64Str');
    return base64Str;
  }
  String decodeStr(String value) {
    final b64 = base64.decode(value);
    final str = utf8.decode(b64);
    log(_debug, '[LocalStore.decodeStr] value: $value to $str');
    return str;
  }
}
