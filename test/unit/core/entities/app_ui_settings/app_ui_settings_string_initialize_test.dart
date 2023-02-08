import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

import 'fake_text_file.dart';

void main() {
  group('AppUiSettingsString initialize', () {
    final validSettings = [
      {
        'text_file': '{"test_setting_1":"asfsaf","test_setting_2":"dfovdfk","test_setting_3":"123546456"}',
        'set_settings': {
          'test_setting_1': 'asfsaf',
          'test_setting_2': 'dfovdfk',
          'test_setting_3': '123546456',
        }
      },
      {
        'text_file': '{"test_setting_1":"!@#\$%^&*()_+-=","test_setting_2":"±§~`;","test_setting_3":".;\\"э"}',
        'set_settings': {
          'test_setting_1': '!@#\$%^&*()_+-=',
          'test_setting_2': '±§~`;',
          'test_setting_3': '.;"э',
        }
      },
    ];
    final invalidSettings = [
      {
        'text_file': '{"test_setting_1":"asd","test_setting_2":true,"test_setting_3":"bcde"}',
        'set_settings': {
          'test_setting_1': 'asd',
          'test_setting_2': true,
          'test_setting_3': 'bcde',
        }
      },
      {
        'text_file': '{"test_setting_1":false,"test_setting_2":123,"test_setting_3":"abc"}',
         'set_settings': {
          'test_setting_1': false,
          'test_setting_2': 123,
          'test_setting_3': 'abc',
        }
      },
      {
        'text_file': '{"test_setting_1":false,"test_setting_2":"fjkdfgjgd","test_setting_3":123.456}',
         'set_settings': {
          'test_setting_1': false,
          'test_setting_2': 'fjkdfgjgd',
          'test_setting_3': 123.456,
        }
      },
    ];
    final invalidJsons = [
      '{',
      'asd',
      '{"test":123'
    ];
    test('sets data normaly with valid json format and valid data', () async {
      for (final settings in validSettings) {
        final textFile = settings['text_file'] as String;
        final setSettings = settings['set_settings'] as Map<String, String>;
        await AppUiSettingsString.initialize(
          jsonMap: JsonMap.fromTextFile(
            FakeTextFile(textFile),
          ),
        );
        expect(AppUiSettingsString.getSetting('test_setting_1'), setSettings['test_setting_1']);
        expect(AppUiSettingsString.getSetting('test_setting_2'), setSettings['test_setting_2']);
        expect(AppUiSettingsString.getSetting('test_setting_3'), setSettings['test_setting_3']);
      }
    });
    test('throws with valid json format and invalid data', () async {
      for (final settings in invalidSettings) {
        final textFile = settings['text_file'] as String;
        expect(
          () => AppUiSettingsString.initialize(
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
        expect(
          () => AppUiSettingsString.initialize(
            jsonMap: JsonMap.fromTextFile(
              FakeTextFile(invalidJson),
            ),
          ),
          throwsA(isA<FormatException>()),
        );
      }
    });
  });
}