import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_log.dart';

int count = 0;
List<Object> logContent = [];

void main() {
  group('Log test', () {
    const target = {
      'all': LogLevel('ALL', 0),
      'debug': LogLevel('DEBUG', 500),
      'config': LogLevel('CONFIG', 700),
      'info': LogLevel('INFO', 800),
      'warning': LogLevel('WARNING', 900),
      'error': LogLevel('ERROR', 1000),
      'off': LogLevel('OFF', 2000),
    };
    setUpAll(() {
      Log.initialize();
    });
    test('Switch level', () {
      expect(Log('name').level, LogLevel.all, reason: 'default level mast be "all"');
      for (final entry in target.entries) {
        final logDebug = Log(entry.key)..level = entry.value;
        expect(logDebug.level, entry.value, reason: 'default level mast be "${entry.value.name}"');
      }
    });
    test('prints messages', () {
      final log = Log('test');
      expect(() => log.debug('debug test message'), returnsNormally);
      expect(() => log.info('info test message'), returnsNormally);
      expect(() => log.warning('warning test message'), returnsNormally);
      expect(() => log.error('error test message'), returnsNormally);
    });
  });
}
