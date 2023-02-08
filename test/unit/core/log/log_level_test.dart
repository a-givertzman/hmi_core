import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_log.dart';

void main() {
  group('LogLevel test', () {
    const target = {
      'all': ['ALL', 0],
      'debug': ['DEBUG', 500],
      'config': ['CONFIG', 700],
      'info': ['INFO', 800],
      'warning': ['WARNING', 900],
      'error': ['ERROR', 1000],
      'off': ['OFF', 2000],
    };
    test('holds valid name and value', () {
      log(true, 'levels: ${LogLevel.levels}');
      for (final level in LogLevel.levels) {
        log(true, 'level: $level');
        final key = level.name.toLowerCase();
        final name = target[key]![0] as String;
        final value = target[key]![1] as int;
        expect(LogLevel(name, value), level);
        expect(LogLevel(name, value).name, name);
        expect(LogLevel(name, value).value, value);
      }
    });
  });
}