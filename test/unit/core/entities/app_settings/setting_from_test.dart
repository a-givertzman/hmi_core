import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';
void main() {
  group('Setting.from', () {
    Log.initialize(level: LogLevel.all);
    const log = Log('Setting');
    const values = [12, -12, 0.44, -0.12, 123.32, -432.21];
    test('toInt', () {
      for (final value in values) {
        final setting = Setting.from(value);
        final vInt = setting.toInt;
        log.debug('value: $value as Int: $vInt');
        expect(vInt, value.toInt());
      }
    });
    test('toDouble', () {
      for (final value in values) {
        final setting = Setting.from(value);
        final vDauble = setting.toDouble;
        log.debug('value: $value as Double: $vDauble');
        expect(vDauble, value);
      }
    });
    test('toString', () {
      const values = [12, -12, 0.44, -0.12, 123.32, -432.21, 'aef323ewf'];
      for (final value in values) {
        final setting = Setting.from(value);
        final vString = setting.toString();
        log.debug('value: $value as Int: $vString');
        expect(vString, '$value');
      }
    });
    test('update', () async {
      const values = [12, -12, 0.44, -0.12, 123.32, -432.21, 'aef323ewf'];
      for (final value in values) {
        final setting = Setting.from(value);
        bool? isUpdateFailed;
        await setting.update(
          value,
          onError: (_) => isUpdateFailed = true,
          onSuccess: () => isUpdateFailed = false,
        );
        expect(isUpdateFailed, isTrue);
      }
    });
  });
}
