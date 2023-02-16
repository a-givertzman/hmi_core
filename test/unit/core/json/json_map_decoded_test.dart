import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/json/json_map.dart';
void main() {
  group('JsonMap decoded', () {
    test('returns valid Map<String, int> on valid jsons', () async {
      final validIntJsons = [
        {
          'text_json': '{"value1":0,"value2":27,"value3":-123}',
          'parsed_map': {
            'value1': 0,
            'value2': 27,
            'value3': -123,
          },
        },
        {
          'text_json': '{"value1":4294967295,"value2":2147483647,"value3":-2147483648}',
          'parsed_map': {
            'value1': 4294967295,
            'value2': 2147483647,
            'value3': -2147483648,
          },
        },
      ];
      for (final validData in validIntJsons) {
        final textJson = validData['text_json'] as String;
        final parsedMap = validData['parsed_map']! as Map<String, int>;
        final jsonMap = JsonMap<int>(textJson);
        expect(await jsonMap.decoded, parsedMap);
      }
    });
    test('returns valid Map<String, bool> on valid jsons', () async {
      final validIntJsons = [
        {
          'text_json': '{"value1":true,"value2":false,"value3":true}',
          'parsed_map': {
            'value1': true,
            'value2': false,
            'value3': true,
          },
        },
        {
          'text_json': '{"value1":false,"value2":false,"value3":false}',
          'parsed_map': {
            'value1': false,
            'value2': false,
            'value3': false,
          },
        },
      ];
      for (final validData in validIntJsons) {
        final textJson = validData['text_json'] as String;
        final parsedMap = validData['parsed_map']! as Map<String, bool>;
        final jsonMap = JsonMap<bool>(textJson);
        expect(await jsonMap.decoded, parsedMap);
      }
    });
    test('returns valid Map<String, double> on valid jsons', () async {
      final validIntJsons = [
        {
          'text_json': '{"value1":0.0,"value2":123.45,"value3":-1.80e308}',
          'parsed_map': {
            'value1': 0.0,
            'value2': 123.45,
            'value3': -1.80e308,
          },
        },
        {
          'text_json': '{"value1":2.23e-308,"value2":-2.23e-308,"value3":1.80e308}',
          'parsed_map': {
            'value1': 2.23e-308,
            'value2': -2.23e-308,
            'value3': 1.80e308,
          },
        },
      ];
      for (final validData in validIntJsons) {
        final textJson = validData['text_json'] as String;
        final parsedMap = validData['parsed_map']! as Map<String, double>;
        final jsonMap = JsonMap<double>(textJson);
        expect(await jsonMap.decoded, parsedMap);
      }
    });
    test('returns valid Map<String, String> on valid jsons', () async {
      final validIntJsons = [
        {
          'text_json': '{"value1":"0.0","value2":"123.45","value3":"-1.80e308"}',
          'parsed_map': {
            'value1': '0.0',
            'value2': '123.45',
            'value3': '-1.80e308',
          },
        },
        {
          'text_json': '{"value1":"abcdefghijklmnopqrstuvwxyz","value2":"1234567890","value3":"!@#\$%^&*()_+-="}',
          'parsed_map': {
            'value1': 'abcdefghijklmnopqrstuvwxyz',
            'value2': '1234567890',
            'value3': '!@#\$%^&*()_+-=',
          },
        },
      ];
      for (final validData in validIntJsons) {
        final textJson = validData['text_json'] as String;
        final parsedMap = validData['parsed_map']! as Map<String, String>;
        final jsonMap = JsonMap<String>(textJson);
        expect(await jsonMap.decoded, parsedMap);
      }
    });
    test('throws on invalid jsons', () {
      final invalidJsons = [
      {
        'text_json': '{',
      },
      {
        'text_json': 'asd',
      },
      {
        'text_json': '{"test":123',
      },
      {
        'text_json': '[',
      },
    ];
      for (final invalidJson in invalidJsons) {
        final textJson = invalidJson['text_json']!;
        final jsonMap = JsonMap(textJson);
        expect(
          () => jsonMap.decoded, 
          throwsA(isA<FormatException>()),
        );
      }
    });
  });
}