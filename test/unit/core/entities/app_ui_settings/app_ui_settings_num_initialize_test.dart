import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

import 'fake_text_file.dart';

void main() {
  group('AppUiSettingsNum initialize', () {
    final validSettings = [
      {
        'text_file': '{"test_setting_1":0,"test_setting_2":27,"test_setting_3":-123}',
        'set_settings': {
          'test_setting_1': 0,
          'test_setting_2': 27,
          'test_setting_3': -123,
        }
      },
      {
        'text_file': '{"test_setting_1":0.0,"test_setting_2":123.45,"test_setting_3":-678.9}',
        'set_settings': {
          'test_setting_1': 0.0,
          'test_setting_2': 123.45,
          'test_setting_3': -678.9,
        }
      },
    ];
    final invalidSettings = [
      {
        'text_file': '{"test_setting_1":"asd","test_setting_2":true,"test_setting_3":"bcde"}',
      },
      {
        'text_file': '{"test_setting_1":false,"test_setting_2":123,"test_setting_3":"abc"}',
      },
      {
        'text_file': '{"test_setting_1":false,"test_setting_2":"fjkdfgjgd","test_setting_3":123.456}',
      },
    ];
    final invalidJsons = [
      {
        'text_file': '{',
      },
      {
        'text_file': 'asd',
      },
      {
        'text_file': '{"test":123',
      },
    ];
    test('sets data normally with valid json format and valid data', () async {
      for (final settings in validSettings) {
        final textFile = settings['text_file'] as String;
        final setSettings = settings['set_settings'] as Map<String, num>;
        await AppUiSettingsNum.initialize(
          textFile: FakeTextFile(textFile),
        );
        expect(AppUiSettingsNum.getSetting('test_setting_1'), setSettings['test_setting_1']);
        expect(AppUiSettingsNum.getSetting('test_setting_2'), setSettings['test_setting_2']);
        expect(AppUiSettingsNum.getSetting('test_setting_3'), setSettings['test_setting_3']);
      }
    });
    test('throws with valid json format and invalid data', () async {
      for (final settings in invalidSettings) {
        final textFile = settings['text_file'] as String;
        expect(
          () => AppUiSettingsNum.initialize(
            textFile: FakeTextFile(textFile),
          ),
          throwsA(isA<TypeError>()),
        );
      }
    });
    test('throws with invalid json format', () {
      for (final invalidJson in invalidJsons) {
        final textFile = invalidJson['text_file'] as String;
        expect(
          () => AppUiSettingsNum.initialize(
            textFile: FakeTextFile(textFile),
          ),
          throwsA(isA<FormatException>()),
        );
      }
    });
  });
}