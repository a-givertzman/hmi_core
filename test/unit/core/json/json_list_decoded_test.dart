import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/json/json_list.dart';
void main() {
  group('JsonList decoded', () {
    test('returns valid List<int> on valid jsons', () async {
      final validIntJsons = [
        {
          'text_json': '[0,27,-123]',
          'parsed_list': [0, 27, -123],
        },
        {
          'text_json': '[4294967295, 2147483647, -2147483648]',
          'parsed_list': [4294967295, 2147483647, -2147483648],
        },
      ];
      for (final validData in validIntJsons) {
        final textJson = validData['text_json'] as String;
        final parsedMap = validData['parsed_list']! as List<int>;
        final jsonMap = JsonList<int>(textJson);
        expect(await jsonMap.decoded, parsedMap);
      }
    });
    test('returns valid List<bool> on valid jsons', () async {
      final validIntJsons = [
        {
          'text_json': '[true,false,true]',
          'parsed_list': [true, false, true],
        },
        {
          'text_json': '[false,false,false]',
          'parsed_list': [false, false, false],
        },
      ];
      for (final validData in validIntJsons) {
        final textJson = validData['text_json'] as String;
        final parsedMap = validData['parsed_list']! as List<bool>;
        final jsonMap = JsonList<bool>(textJson);
        expect(await jsonMap.decoded, parsedMap);
      }
    });
    test('returns valid List<double> on valid jsons', () async {
      final validIntJsons = [
        {
          'text_json': '[0.0,123.45,-1.80e308]',
          'parsed_list': [0.0, 123.45, -1.80e308],
        },
        {
          'text_json': '[2.23e-308,-2.23e-308,1.80e308]',
          'parsed_list': [2.23e-308, -2.23e-308, 1.80e308],
        },
      ];
      for (final validData in validIntJsons) {
        final textJson = validData['text_json'] as String;
        final parsedMap = validData['parsed_list']! as List<double>;
        final jsonMap = JsonList<double>(textJson);
        expect(await jsonMap.decoded, parsedMap);
      }
    });
    test('returns valid List<String> on valid jsons', () async {
      final validIntJsons = [
        {
          'text_json': '["0.0","123.45","-1.80e308"]',
          'parsed_list': ["0.0", "123.45", "-1.80e308"],
        },
        {
          'text_json': '["abcdefghijklmnopqrstuvwxyz","1234567890","!@#\$%^&*()_+-="]',
          'parsed_list': ["abcdefghijklmnopqrstuvwxyz", "1234567890", "!@#\$%^&*()_+-="],
        },
      ];
      for (final validData in validIntJsons) {
        final textJson = validData['text_json'] as String;
        final parsedMap = validData['parsed_list']! as List<String>;
        final jsonMap = JsonList<String>(textJson);
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
        final jsonMap = JsonList(textJson);
        expect(
          () => jsonMap.decoded, 
          throwsA(isA<FormatException>()),
        );
      }
    });
  });
}