import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';
import 'package:hmi_core/src/core/json/json_map.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/result/result.dart';
import 'package:hmi_core/src/core/error/failure.dart';
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
  final validReadOnlyMaps = [
    {
      'test_setting_1': 0,
      'test_setting_2': 27,
      'test_setting_3': -123,
    }, // int
    {
      'test_setting_1': 0.0,
      'test_setting_2': 27.0,
      'test_setting_3': -123.0,
    }, // double
    {
      'test_setting_1': '0',
      'test_setting_2': '27',
      'test_setting_3': '-123',
    }, // string
    {
      'test_setting_1': true,
      'test_setting_2': false,
      'test_setting_3': true,
    }, // bool
  ];
  final validWritableMaps = [
    {
      'test_writable_setting_1': 0,
      'test_writable_setting_2': 27,
      'test_writable_setting_3': -123,
    }, // int
    {
      'test_writable_setting_1': 0.0,
      'test_writable_setting_2': 27.0,
      'test_writable_setting_3': -123.0,
    }, // double
    {
      'test_writable_setting_1': '0',
      'test_writable_setting_2': '27',
      'test_writable_setting_3': '-123',
    }, // string
    {
      'test_writable_setting_1': true,
      'test_writable_setting_2': false,
      'test_writable_setting_3': true,
    }, // bool
  ];
  group('AppSettings initialize', () {
    test('sets data normally with valid readOnly json map', () async {
      //
      for (final map in validReadOnlyMaps) {
        await AppSettings.initialize(readOnly: FakeJsonMap(Ok(map)));
        expect(
          AppSettings.getSetting('test_setting_1', onError: ((err) => null)),
          map['test_setting_1'],
        );
        expect(
          AppSettings.getSetting('test_setting_2', onError: ((err) => null)),
          map['test_setting_2'],
        );
        expect(
          AppSettings.getSetting('test_setting_3', onError: ((err) => null)),
          map['test_setting_3'],
        );
      }
    });
    test('sets data normally with valid writable json map', () async {
      for (final map in validWritableMaps) {
        await AppSettings.initialize(writable: FakeJsonMap(Ok(map)));
        expect(
          AppSettings.getSetting('test_writable_setting_1', onError: ((err) => null)),
          map['test_writable_setting_1'],
        );
        expect(
          AppSettings.getSetting('test_writable_setting_2', onError: ((err) => null)),
          map['test_writable_setting_2'],
        );
        expect(
          AppSettings.getSetting('test_writable_setting_3', onError: ((err) => null)),
          map['test_writable_setting_3'],
        );
      }
    });
    test('writable settings overwrite readOnly settings', () async {
      await AppSettings.initialize(
        readOnly: const FakeJsonMap(Ok({
          'test_overwrite_setting_1': 0,
          'test_overwrite_setting_2': 27,
          'test_overwrite_setting_3': -123,
        })),
        writable: const FakeJsonMap(Ok({
          'test_overwrite_setting_1': -123,
          'test_overwrite_setting_2': 0,
          'test_overwrite_setting_3': 27,
        })),
      );
      expect(AppSettings.getSetting('test_overwrite_setting_1'), -123);
      expect(AppSettings.getSetting('test_overwrite_setting_2'), 0);
      expect(AppSettings.getSetting('test_overwrite_setting_3'), 27);
    });
    test('getSetting onError passes new value case error', () async {
      final notFoundMaps = [
        {
          'key': 'not_found_1',
          'map_value': 0,
        }, // int
        {
          'key': 'not_found_2',
          'map_value': 0.0,
        }, // int
        {
          'key': 'not_found_3',
          'map_value': false,
        }, // bool
        {
          'key': 'not_found_4',
          'map_value': '0',
        }, // string
        {
          'key': 'not_found_5',
          'map_value': null,
        }, // null
      ];
      for (final map in notFoundMaps) {
        await AppSettings.initialize();
        final key = map['key'] as String;
        final mapValue = map['map_value'] as dynamic;
        expect(
          AppSettings.getSetting(key, onError: ((err) => mapValue)),
          mapValue,
        );
      }
    });
    test('does not throw error with invalid json map', () async {
      final mapWithError = FakeJsonMap(
        Err(Failure(
          message: 'invalid json map',
          stackTrace: StackTrace.current,
        )),
      );
      await expectLater(
        AppSettings.initialize(readOnly: mapWithError),
        completes,
      );
      await expectLater(
        AppSettings.initialize(writable: mapWithError),
        completes,
      );
      await expectLater(
        AppSettings.initialize(readOnly: mapWithError, writable: mapWithError),
        completes,
      );
    });
  });
}
