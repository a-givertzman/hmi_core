import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_text_file.dart';
import 'package:hmi_core/src/core/json/json_map.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/result/result.dart';
///
/// Fake implementation of [TextFile]
class FakeTextFile implements TextFile {
  ResultF<String> _content;
  final Future<void> Function(String value)? writeFuture;
  ///
  /// Creates [FakeTextFile] with a given [content] if provided.
  FakeTextFile(ResultF<String> content, {this.writeFuture})
      : _content = content;
  //
  @override
  Future<ResultF<String>> get content async {
    return _content;
  }
  //
  @override
  Future<void> write(String text) async {
    await writeFuture?.call(text);
    _content = Ok(text);
  }
}
//
void main() {
  Log.initialize();
  group('JsonMap.fromTextFiles decoded', () {
    test('returns valid Map<String, int> on valid jsons', () async {
      final validIntJsons = [
        '{"value1":0,"value2":27,"value3":-123}',
        '{"value4":4294967295,"value5":2147483647,"value6":-2147483648}',
      ];
      final parsedMap = {
        'value1': 0,
        'value2': 27,
        'value3': -123,
        'value4': 4294967295,
        'value5': 2147483647,
        'value6': -2147483648,
      };
      final jsonMap = JsonMap<int>.fromTextFiles(
        validIntJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonMap.decoded;
      expect(result, isA<Ok>());
      final decodedJson = (await jsonMap.decoded as Ok).value;
      expect(decodedJson, equals(parsedMap));
    });
    test('returns valid Map<String, bool> on valid jsons', () async {
      final validBoolJsons = [
        '{"value1":true,"value2":false,"value3":true}',
        '{"value4":false,"value5":false,"value6":false}',
      ];
      final parsedMap = {
        'value1': true,
        'value2': false,
        'value3': true,
        'value4': false,
        'value5': false,
        'value6': false,
      };
      final jsonMap = JsonMap<bool>.fromTextFiles(
        validBoolJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonMap.decoded;
      expect(result, isA<Ok>());
      final decodedJson = (await jsonMap.decoded as Ok).value;
      expect(decodedJson, equals(parsedMap));
    });
    test('returns valid Map<String, double> on valid jsons', () async {
      final validDoubleJsons = [
        '{"value1":0.0,"value2":123.45,"value3":-1.80e308}',
        '{"value4":2.23e-308,"value5":-2.23e-308,"value6":1.80e308}',
      ];
      final parsedMap = {
        'value1': 0.0,
        'value2': 123.45,
        'value3': -1.80e308,
        'value4': 2.23e-308,
        'value5': -2.23e-308,
        'value6': 1.80e308,
      };
      final jsonMap = JsonMap<double>.fromTextFiles(
        validDoubleJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonMap.decoded;
      expect(result, isA<Ok>());
      final decodedJson = (await jsonMap.decoded as Ok).value;
      expect(decodedJson, equals(parsedMap));
    });
    test('returns valid Map<String, String> on valid jsons', () async {
      final validStringJsons = [
        '{"value1":"0.0","value2":"123.45","value3":"-1.80e308"}',
        '{"value4":"abcdefghijklmnopqrstuvwxyz","value5":"1234567890","value6":"!@#\$%^&*()_+-="}',
      ];
      final parsedMap = {
        'value1': '0.0',
        'value2': '123.45',
        'value3': '-1.80e308',
        'value4': 'abcdefghijklmnopqrstuvwxyz',
        'value5': '1234567890',
        'value6': '!@#\$%^&*()_+-=',
      };
      final jsonMap = JsonMap<String>.fromTextFiles(
        validStringJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonMap.decoded;
      expect(result, isA<Ok>());
      final decodedJson = (await jsonMap.decoded as Ok).value;
      expect(decodedJson, equals(parsedMap));
    });
    test('rewrites values in order of passed files', () async {
      final validJsons = [
        '{"value1":1,"value2":1,"value3":1}',
        '{"value2":2,"value3":2}',
        '{"value3":3}',
      ];
      final parsedMap = {
        'value1': 1,
        'value2': 2,
        'value3': 3,
      };
      final jsonMap = JsonMap<dynamic>.fromTextFiles(
        validJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonMap.decoded;
      expect(result, isA<Ok>());
      final decodedJson = (await jsonMap.decoded as Ok).value;
      expect(decodedJson, equals(parsedMap));
    });
    test('returns Err on invalid jsons', () async {
      final invalidJsons = [
        '{',
        'asd',
        '{"test":123',
        '[',
      ];
      final jsonMap = JsonMap.fromTextFiles(
        invalidJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonMap.decoded;
      expect(result, isA<Err>());
    });
    test('returns Err on valid non-map jsons', () async {
      final invalidMapJsons = [
        '[]',
        'true',
        'false',
        'null',
        '"valid"',
        '123',
        '123.45',
      ];
      final jsonMap = JsonMap.fromTextFiles(
        invalidMapJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonMap.decoded;
      expect(result, isA<Err>());
    });
    test('returns Err if any json is invalid', () async {
      final invalidJsons = [
        '{"validJson":true}',
        '{',
        'asd',
        '{"test":123',
        '[',
      ];
      final jsonMap = JsonMap.fromTextFiles(
        invalidJsons.map((json) => FakeTextFile(Ok(json))).toList(),
      );
      final result = await jsonMap.decoded;
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
          message: '{"validJson":true}',
          stackTrace: StackTrace.current,
        ))),
      ];
      final jsonMap = JsonMap.fromTextFiles(filesWithError);
      final result = await jsonMap.decoded;
      expect(result, isA<Err>());
    });
    test('returns Err if any TextFile with error', () async {
      final filesWithError = [
        FakeTextFile(const Ok('{"validJson":true}')),
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
      final jsonMap = JsonMap.fromTextFiles(filesWithError);
      final result = await jsonMap.decoded;
      expect(result, isA<Err>());
    });
    test('does not write to input file', () async {
      bool isWritten = false;
      final jsonMap = JsonMap.fromTextFiles([
        FakeTextFile(
          const Ok('{"validJson":true}'),
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
