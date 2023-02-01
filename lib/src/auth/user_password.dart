import 'dart:math';
import 'package:hmi_core/src/core/validation_result.dart';

class UserPassword {
  final minLength = 1;
  final maxLength = 30;
  final String _value;
  final String _key;
  UserPassword({
    required String value,
    required String key,
  }):
    _value = value,
    _key = key;
  factory UserPassword.generate(int length1, int length2, String key) {
    final part1 = _generateRandomString(length1);
    final part2 = _generateRandomString(length2);
    return UserPassword(value: '$part1-$part2', key: key);
  }
  String value() => _value;
  String encrypted() {
    return _encrypt(_value, _key);
  }
  String decrypted() {
    return _decrypt(_value, _key);
  }
  ValidationResult validate() {
    final regex = RegExp('^.{$minLength,$maxLength}\$');
    final valid = regex.hasMatch(_value);
    return ValidationResult(
      valid: valid,
      message: valid ? null : 'Символов не менее: $minLength',
    );
  }
  String _encrypt(String source, String key) {
    final s = StringBuffer();
    final lKey = _escape(key);
    final List<int> lSource = _escape(source);
    final List<int> k = List.filled(lKey.length, 0);
    for (var i = 0; i < lKey.length; i++) {
      final keySlice = lKey[i];
      k[i] = keySlice;
    }
    for (var i = 0; i < lSource.length; i++) {
      s.write(
        _encode(lSource[i], k).toString(),
      );
      s.write(
        (i < lSource.length -1) ? ',' : '',
      );
    }
    // print('_encrypt s: $s');
    return s.toString();
  }  
  String _decrypt(String source, String key) {
    final s = StringBuffer();
    final lKey = _escape(key);
    final List<int> lSource = source.split(',').map((str) => int.parse(str)).toList();
    final List<int> k = List.filled(lKey.length, 0);
    for (var i = 0; i < lKey.length; i++) {
      final keySlice = lKey[i];
      k[i] = keySlice;
    }
    for (var i = 0; i < lSource.length; i++) {
      s.write(
        _decode(lSource[i], k).toString(),
      );
      s.write(
        (i < lSource.length -1) ? ',' : '',
      );
    }
    return _unescape(s.toString());
  }
  List<int> _escape(String str) {
    return str.split('').map((c) => c.codeUnitAt(0)).toList();
  }
  String _unescape(String value) {
    final strCodes = value.split(',');
    final intCodes = strCodes.map((str) => int.parse(str));
    return String.fromCharCodes([...intCodes]);
  }
  int _encode(int v, List<int> k) {
    var y = v;
    // var z = v;
    const delta = 0x9E3779B9;
    var sum = 0;
    for (var i = 0; i < 32; i++) {
      final add1 = k[sum & 3];
      y += (add1 ^ i) + add1;
      sum += delta;
    }
    // print(index);
    return y;
  }
  int _decode(int v, List<int> k) {
    // var y = v;
    var z = v;
    const delta = 0x9E3779B9;
    var sum = delta * 32;
    for (var i = 31; i >= 0; i--) {
      final add2 = k[sum & 3];
      z -= (add2 ^ i) + add2;
      sum -= delta;
    }
    return z;
  }
}
String _generateRandomString(int len) {
  const chars = '!%&AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!%&';
  final r = Random.secure();
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}
