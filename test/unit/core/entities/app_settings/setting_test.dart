import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';
import 'fake_text_file.dart';
import 'settings_data.dart';

void main() {
  Log.initialize();
  group('Setting', () {
    Log.initialize(level: LogLevel.all);
    const log = Log('Setting');
    test('valid data', () async {
      for (final settings in validSettings) {
        final textFile = settings['text_file'] as String;
        final setSettings = settings['set_settings'] as Map<String, num>;
        await AppSettings.initialize(
          jsonMap: JsonMap.fromTextFile(
            FakeTextFile(textFile),
          ),
        );
        for (final setting in setSettings.entries) {
          final int testSetting = Setting(setting.key).toInt;
          log.debug('as Int | ${setting.key}: $testSetting');
        }
        for (final setting in setSettings.entries) {
          final double testSetting = Setting(setting.key).toDouble;
          log.debug('as Double | ${setting.key}: $testSetting');
        }
        for (final setting in setSettings.entries) {
          final String testSetting = Setting(setting.key).toString();
          log.debug('as String | ${setting.key}: $testSetting');
        }
        expect(const Setting('test_setting_1').toInt, setSettings['test_setting_1']!.toInt());
        expect(const Setting('test_setting_2').toInt, setSettings['test_setting_2']!.toInt());
        expect(const Setting('test_setting_3').toInt, setSettings['test_setting_3']!.toInt());
        expect(const Setting('test_setting_1').toDouble, setSettings['test_setting_1']!.toDouble());
        expect(const Setting('test_setting_2').toDouble, setSettings['test_setting_2']!.toDouble());
        expect(const Setting('test_setting_3').toDouble, setSettings['test_setting_3']!.toDouble());
        expect(const Setting('test_setting_1').toString(), setSettings['test_setting_1']!.toString());
        expect(const Setting('test_setting_2').toString(), setSettings['test_setting_2']!.toString());
        expect(const Setting('test_setting_3').toString(), setSettings['test_setting_3']!.toString());
      }
    });
    test('valid data with factor', () async {
      const factors = [0.123, -0.123, 3.54, -5.12];
      for (final factor in factors) {
        for (final settings in validSettings) {
          final textFile = settings['text_file'] as String;
          final setSettings = settings['set_settings'] as Map<String, num>;
          await AppSettings.initialize(
            jsonMap: JsonMap.fromTextFile(
              FakeTextFile(textFile),
            ),
          );
          for (final setting in setSettings.entries) {
            final int testSetting = Setting(setting.key, factor: factor).toInt;
            log.debug('as Int | ${setting.key} * $factor: $testSetting');
          }
          for (final setting in setSettings.entries) {
            final double testSetting = Setting(setting.key, factor: factor).toDouble;
            log.debug('as Double | ${setting.key} * $factor: $testSetting');
          }
          const factorConst = 0.123;
          const setting = Setting('test_setting_1', factor: factorConst);
          expect(setting.toInt, (setSettings['test_setting_1']! * factor).toInt());
          expect(Setting('test_setting_1', factor: factor).toInt, (setSettings['test_setting_1']! * factor).toInt());
          expect(Setting('test_setting_2', factor: factor).toInt, (setSettings['test_setting_2']! * factor).toInt());
          expect(Setting('test_setting_3', factor: factor).toInt, (setSettings['test_setting_3']! * factor).toInt());
          expect(Setting('test_setting_1', factor: factor).toDouble, (setSettings['test_setting_1']! * factor).toDouble());
          expect(Setting('test_setting_2', factor: factor).toDouble, (setSettings['test_setting_2']! * factor).toDouble());
          expect(Setting('test_setting_3', factor: factor).toDouble, (setSettings['test_setting_3']! * factor).toDouble());
        }
      }
    });
    test('does not throw with invalid json', () {
      for (final invalidJson in invalidJsons) {
        final textFile = invalidJson['text_file'] as String;
        expectLater(AppSettings.initialize(
            jsonMap: JsonMap.fromTextFile(
              FakeTextFile(textFile),
            ),
          ),
          completes,
        );
      }
    });
  });
}