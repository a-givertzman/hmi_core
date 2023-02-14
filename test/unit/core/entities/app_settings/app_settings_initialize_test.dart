import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

import 'fake_text_file.dart';
import 'settings_data.dart';

void main() {
  group('AppUiSettingsNum initialize', () {
    test('sets data normally with valid json format and valid data', () async {
      for (final settings in validSettings) {
        final textFile = settings['text_file'] as String;
        final setSettings = settings['set_settings'] as Map<String, num>;
        await AppSettings.initialize(
          jsonMap: JsonMap.fromTextFile(
            FakeTextFile(textFile),
          ),
        );
        expect(AppSettings.getSetting('test_setting_1'), setSettings['test_setting_1']);
        expect(AppSettings.getSetting('test_setting_2'), setSettings['test_setting_2']);
        expect(AppSettings.getSetting('test_setting_3'), setSettings['test_setting_3']);
      }
    });
    test('throws with valid json format and invalid data', () async {
      for (final settings in invalidSettings) {
        final textFile = settings['text_file'] as String;
        expect(
          () => AppSettings.initialize(
            jsonMap: JsonMap.fromTextFile(
              FakeTextFile(textFile),
            ),
          ),
          throwsA(isA<TypeError>()),
        );
      }
    });
    test('throws with invalid json format', () {
      for (final invalidJson in invalidJsons) {
        final textFile = invalidJson['text_file'] as String;
        expect(
          () => AppSettings.initialize(
            jsonMap: JsonMap.fromTextFile(
              FakeTextFile(textFile),
            ),
          ),
          throwsA(isA<FormatException>()),
        );
      }
    });
  });
}