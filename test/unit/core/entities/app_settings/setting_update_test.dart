import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/app_settings/app_settings.dart';
import 'package:hmi_core/src/app_settings/setting.dart';
import 'package:hmi_core/src/core/json/json_map.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/result/result.dart';
import 'fake_text_file.dart';
///
/// Fake implementation of [JsonMap] for tests
class FakeJsonMap implements JsonMap<dynamic> {
  final ResultF<Map<String, dynamic>> _map;
  ///
  /// Creates [FakeJsonMap] with a given [map].
  const FakeJsonMap(ResultF<Map<String, dynamic>> map) : _map = map;
  //
  @override
  Future<ResultF<Map<String, dynamic>>> get decoded async {
    return _map;
  }
}
//
void main() {
  Log.initialize();
  final testsData = [
    {
      'key': 'test_write_setting',
      'map': {"test_write_setting": 0},
      'write_json': '{"test_write_setting":0}',
      'set_value': 0,
    }, // same value
    {
      'key': 'test_write_setting',
      'map': {"test_write_setting": 0},
      'write_json': '{"test_write_setting":-27}',
      'set_value': -27,
    }, // int
    {
      'key': 'test_write_setting',
      'map': {"test_write_setting": 0},
      'write_json': '{"test_write_setting":-27.0}',
      'set_value': -27.0,
    }, // double
    {
      'key': 'test_write_setting',
      'map': {"test_write_setting": 0},
      'write_json': '{"test_write_setting":"abc"}',
      'set_value': 'abc',
    }, // string
    {
      'key': 'test_write_setting',
      'map': {"test_write_setting": 0},
      'write_json': '{"test_write_setting":true}',
      'set_value': true,
    }, // bool
    {
      'key': 'test_write_setting',
      'map': {"test_write_setting": 0},
      'write_json': '{"test_write_setting":null}',
      'set_value': null,
    }, // null
  ];
  group('Setting update', () {
    test('write setting to file', () async {
      for (final data in testsData) {
        final key = data['key'] as String;
        final map = data['map'] as Map<String, dynamic>;
        final setValue = data['set_value'] as dynamic;
        final writeJson = data['write_json'] as String;
        String writeContent = '';
        final writeFile = FakeTextFile(
          writeContent,
          writeFuture: (value) async {
            writeContent = value;
          },
        );
        await AppSettings.initialize(
          writable: FakeJsonMap(Ok(map)),
          store: writeFile,
        );
        await Setting(key).update(setValue);
        expect(writeJson, writeContent);
      }
    });
    test('update setting value', () async {
      for (final data in testsData) {
        final key = data['key'] as String;
        final map = data['map'] as Map<String, dynamic>;
        final setValue = data['set_value'] as dynamic;
        final writeFile = FakeTextFile(
          '',
          writeFuture: (_) => Future.value(),
        );
        await AppSettings.initialize(
          writable: FakeJsonMap(Ok(map)),
          store: writeFile,
        );
        await Setting(key).update(setValue);
        expect(AppSettings.getSetting(key), setValue);
      }
    });
    test('call onSuccess if setting saved successfully', () async {
      for (final data in testsData) {
        bool isSuccess = false;
        bool isError = false;
        final key = data['key'] as String;
        final map = data['map'] as Map<String, dynamic>;
        final setValue = data['set_value'] as dynamic;
        final writeFile = FakeTextFile(
          '',
          writeFuture: (_) => Future.value(),
        );
        await AppSettings.initialize(
          writable: FakeJsonMap(Ok(map)),
          store: writeFile,
        );
        await Setting(key).update(
          setValue,
          onSuccess: () {
            isSuccess = true;
          },
          onError: (_) {
            isError = true;
          },
        );
        expect(isSuccess, isTrue);
        expect(isError, isFalse);
      }
    });
    test('call onError if setting saved with error', () async {
      for (final data in testsData) {
        bool isSuccess = false;
        bool isError = false;
        final key = data['key'] as String;
        final map = data['map'] as Map<String, dynamic>;
        final setValue = data['set_value'] as dynamic;
        final writeFile = FakeTextFile(
          '',
          writeFuture: (_) => Future.error('write error'),
        );
        await AppSettings.initialize(
          writable: FakeJsonMap(Ok(map)),
          store: writeFile,
        );
        await Setting(key).update(
          setValue,
          onSuccess: () {
            isSuccess = true;
          },
          onError: (_) {
            isError = true;
          },
        );
        expect(isSuccess, isFalse);
        expect(isError, isTrue);
      }
    });
    test('call onError if setting is not found', () async {
      bool isSuccess = false;
      bool isError = false;
      final writeFile = FakeTextFile(
        '',
        writeFuture: (_) => Future.error('write error'),
      );
      await AppSettings.initialize(
        store: writeFile,
      );
      await const Setting('test_not_found_setting').update(
        10,
        onSuccess: () {
          isSuccess = true;
        },
        onError: (_) {
          isError = true;
        },
      );
      expect(isSuccess, isFalse);
      expect(isError, isTrue);
    });
    test('call onError if setting is not writable', () async {
      bool isSuccess = false;
      bool isError = false;
      final writeFile = FakeTextFile(
        '',
        writeFuture: (_) => Future.error('write error'),
      );
      await AppSettings.initialize(
        readOnly: const FakeJsonMap(Ok({'test_not_write_setting': 0})),
        store: writeFile,
      );
      await const Setting('test_not_write_setting').update(
        10,
        onSuccess: () {
          isSuccess = true;
        },
        onError: (_) {
          isError = true;
        },
      );
      expect(isSuccess, isFalse);
      expect(isError, isTrue);
    });
    test('returns setting to previous value on error', () async {
      for (final data in testsData) {
        final key = data['key'] as String;
        final map = data['map'] as Map<String, dynamic>;
        final setValue = data['set_value'] as dynamic;
        final writeFile = FakeTextFile(
          '',
          writeFuture: (_) => Future.error('write error'),
        );
        await AppSettings.initialize(
          writable: FakeJsonMap(Ok(map)),
          store: writeFile,
        );
        await AppSettings.setSetting(key, setValue);
        expect(AppSettings.getSetting(key), map[key]);
      }
    });
  });
}
