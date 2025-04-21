import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/json/json_list.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/result/result.dart';
import 'json_map_from_text_file_test.dart';
//
void main() {
  Log.initialize();
  group('JsonList.fromTextFiles decoded', () {
    test('returns valid List<int> on valid jsons', () async {
      final validIntJsons = [
        '[0,27,-123]',
        '[4294967295, 2147483647, -2147483648]',
      ];
      final parsedList = [0, 27, -123, 4294967295, 2147483647, -2147483648];
      final jsonList = JsonList<int>.fromTextFiles(
        validIntJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonList.decoded;
      expect(result, isA<Ok>());
      final decodedJson = (await jsonList.decoded as Ok).value;
      expect(decodedJson, equals(parsedList));
    });
    test('returns valid List<bool> on valid jsons', () async {
      final validBoolJsons = [
        '[true,false,true]',
        '[false,false,false]',
      ];
      final parsedList = [true, false, true, false, false, false];
      final jsonList = JsonList<bool>.fromTextFiles(
        validBoolJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonList.decoded;
      expect(result, isA<Ok>());
      final decodedJson = (await jsonList.decoded as Ok).value;
      expect(decodedJson, equals(parsedList));
    });
    test('returns valid List<double> on valid jsons', () async {
      final validDoubleJsons = [
        '[0.0,123.45,-1.80e308]',
        '[2.23e-308,-2.23e-308,1.80e308]',
      ];
      final parsedList = [
        0.0,
        123.45,
        -1.80e308,
        2.23e-308,
        -2.23e-308,
        1.80e308,
      ];
      final jsonList = JsonList<double>.fromTextFiles(
        validDoubleJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonList.decoded;
      expect(result, isA<Ok>());
      final decodedJson = (await jsonList.decoded as Ok).value;
      expect(decodedJson, equals(parsedList));
    });
    test('returns valid List<String> on valid jsons', () async {
      final validStringJsons = [
        '["0.0","123.45","-1.80e308"]',
        '["abcdefghijklmnopqrstuvwxyz","1234567890","!@#\$%^&*()_+-="]',
      ];
      final parsedList = [
        '0.0',
        '123.45',
        '-1.80e308',
        'abcdefghijklmnopqrstuvwxyz',
        '1234567890',
        '!@#\$%^&*()_+-=',
      ];
      final jsonList = JsonList<String>.fromTextFiles(
        validStringJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonList.decoded;
      expect(result, isA<Ok>());
      final decodedJson = (await jsonList.decoded as Ok).value;
      expect(decodedJson, equals(parsedList));
    });
    test('returns Err on invalid jsons', () async {
      final invalidJsons = [
        '{',
        'asd',
        '{"test":123',
        '[',
      ];
      final jsonList = JsonList<dynamic>.fromTextFiles(
        invalidJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonList.decoded;
      expect(result, isA<Err>());
    });
    test('returns Err on valid non-list json', () async {
      final invalidListJsons = [
        '{}',
        'true',
        'false',
        'null',
        '"valid"',
        '123',
        '123.45',
      ];
      final jsonList = JsonList<dynamic>.fromTextFiles(
        invalidListJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonList.decoded;
      expect(result, isA<Err>());
    });
    test('does not write to input file', () async {
      bool isWritten = false;
      final jsonMap = JsonList.fromTextFile(
        FakeTextFile(
          const Ok('["valid", "json"]'),
          writeFuture: (_) async {
            isWritten = true;
          },
        ),
      );
      await jsonMap.decoded;
      expect(isWritten, isFalse);
    });
    test('returns Err if any json is invalid', () async {
      final invalidJsons = [
        '["valid","json"]',
        '{',
        'asd',
        '{"test":123',
        '[',
      ];
      final jsonList = JsonList.fromTextFiles(
        invalidJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonList.decoded;
      expect(result, isA<Err>());
    });
    test('returns Err on TextFile error', () async {
      final filesWithError = [
        FakeTextFile(Err(Failure(
          message: null,
          stackTrace: StackTrace.current,
        ))),
        FakeTextFile(Err(Failure(
          message: '',
          stackTrace: StackTrace.current,
        ))),
        FakeTextFile(Err(Failure(
          message: '["valid","json"]',
          stackTrace: StackTrace.current,
        ))),
      ];
      final jsonList = JsonList.fromTextFiles(filesWithError);
      final result = await jsonList.decoded;
      expect(result, isA<Err>());
    });
    test('returns Err if any TextFile with error', () async {
      final filesWithError = [
        FakeTextFile(const Ok('["valid","json"]')),
        FakeTextFile(Err(Failure(
          message: null,
          stackTrace: StackTrace.current,
        ))),
        FakeTextFile(Err(Failure(
          message: '',
          stackTrace: StackTrace.current,
        ))),
        FakeTextFile(Err(Failure(
          message: '{"validJson":true}',
          stackTrace: StackTrace.current,
        ))),
      ];
      final jsonList = JsonList.fromTextFiles(filesWithError);
      final result = await jsonList.decoded;
      expect(result, isA<Err>());
    });
    test('does not write to input file', () async {
      bool isWritten = false;
      final jsonMap = JsonList.fromTextFiles([
        FakeTextFile(
          const Ok('["valid","json"]'),
          writeFuture: (_) async {
            isWritten = true;
          },
        ),
        FakeTextFile(
          const Ok('invalid json'),
          writeFuture: (_) async {
            isWritten = true;
          },
        ),
      ]);
      await jsonMap.decoded;
      expect(isWritten, isFalse);
    });
  });
}
