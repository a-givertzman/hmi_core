import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/json/json_map.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/result/result.dart';
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
  final List<Map<String, dynamic>> validReadOnlyMaps = [
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
  ];
  final List<Map<String, dynamic>> validWritableMaps = [
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
  ];
  group('Setting with writable', () {
    Log.initialize();
    const log = Log('Setting ');
    test('valid writable data', () async {
      for (final writable in validWritableMaps) {
        await AppSettings.initialize(writable: FakeJsonMap(Ok(writable)));
        for (final setting in writable.entries) {
          final int testSetting = Setting(setting.key).toInt;
          log.debug('as Int | ${setting.key}: $testSetting');
        }
        for (final setting in writable.entries) {
          final double testSetting = Setting(setting.key).toDouble;
          log.debug('as Double | ${setting.key}: $testSetting');
        }
        for (final setting in writable.entries) {
          final String testSetting = Setting(setting.key).toString();
          log.debug('as String | ${setting.key}: $testSetting');
        }
        expect(const Setting('test_writable_setting_1').toInt, writable['test_writable_setting_1']!.toInt());
        expect(const Setting('test_writable_setting_2').toInt, writable['test_writable_setting_2']!.toInt());
        expect(const Setting('test_writable_setting_3').toInt, writable['test_writable_setting_3']!.toInt());
        expect(const Setting('test_writable_setting_1').toDouble, writable['test_writable_setting_1']!.toDouble());
        expect(const Setting('test_writable_setting_2').toDouble, writable['test_writable_setting_2']!.toDouble());
        expect(const Setting('test_writable_setting_3').toDouble, writable['test_writable_setting_3']!.toDouble());
        expect(const Setting('test_writable_setting_1').toString(), writable['test_writable_setting_1']!.toString());
        expect(const Setting('test_writable_setting_2').toString(), writable['test_writable_setting_2']!.toString());
        expect(const Setting('test_writable_setting_3').toString(), writable['test_writable_setting_3']!.toString());
      }
    });
    test('valid read only and writable data', () async {
      for (final readOnly in validReadOnlyMaps) {
        for (final writable in validWritableMaps) {
          await AppSettings.initialize(
            readOnly: FakeJsonMap(Ok(readOnly)),
            writable: FakeJsonMap(Ok(writable)),
          );
          for (final setting in readOnly.entries) {
            final int testSetting = Setting(setting.key).toInt;
            log.debug('as Int | ${setting.key}: $testSetting');
          }
          for (final setting in readOnly.entries) {
            final double testSetting = Setting(setting.key).toDouble;
            log.debug('as Double | ${setting.key}: $testSetting');
          }
          for (final setting in readOnly.entries) {
            final String testSetting = Setting(setting.key).toString();
            log.debug('as String | ${setting.key}: $testSetting');
          }
          expect(const Setting('test_setting_1').toInt, readOnly['test_setting_1']!.toInt());
          expect(const Setting('test_setting_2').toInt, readOnly['test_setting_2']!.toInt());
          expect(const Setting('test_setting_3').toInt, readOnly['test_setting_3']!.toInt());
          expect(const Setting('test_setting_1').toDouble, readOnly['test_setting_1']!.toDouble());
          expect(const Setting('test_setting_2').toDouble, readOnly['test_setting_2']!.toDouble());
          expect(const Setting('test_setting_3').toDouble, readOnly['test_setting_3']!.toDouble());
          expect(const Setting('test_setting_1').toString(), readOnly['test_setting_1']!.toString());
          expect(const Setting('test_setting_2').toString(), readOnly['test_setting_2']!.toString());
          expect(const Setting('test_setting_3').toString(), readOnly['test_setting_3']!.toString());
          for (final setting in writable.entries) {
            final int testSetting = Setting(setting.key).toInt;
            log.debug('as Int | ${setting.key}: $testSetting');
          }
          for (final setting in writable.entries) {
            final double testSetting = Setting(setting.key).toDouble;
            log.debug('as Double | ${setting.key}: $testSetting');
          }
          for (final setting in writable.entries) {
            final String testSetting = Setting(setting.key).toString();
            log.debug('as String | ${setting.key}: $testSetting');
          }
          expect(const Setting('test_writable_setting_1').toInt, writable['test_writable_setting_1']!.toInt());
          expect(const Setting('test_writable_setting_2').toInt, writable['test_writable_setting_2']!.toInt());
          expect(const Setting('test_writable_setting_3').toInt, writable['test_writable_setting_3']!.toInt());
          expect(const Setting('test_writable_setting_1').toDouble, writable['test_writable_setting_1']!.toDouble());
          expect(const Setting('test_writable_setting_2').toDouble, writable['test_writable_setting_2']!.toDouble());
          expect(const Setting('test_writable_setting_3').toDouble, writable['test_writable_setting_3']!.toDouble());
          expect(const Setting('test_writable_setting_1').toString(), writable['test_writable_setting_1']!.toString());
          expect(const Setting('test_writable_setting_2').toString(), writable['test_writable_setting_2']!.toString());
          expect(const Setting('test_writable_setting_3').toString(), writable['test_writable_setting_3']!.toString());
        }
      }
    });
    test('writable key not found', () async {
      for (final settings in validWritableMaps) {
        await AppSettings.initialize(writable: FakeJsonMap(Ok(settings)));
        for (final setting in settings.entries) {
          final int testSetting = Setting(setting.key).toInt;
          log.debug('as Int | ${setting.key}: $testSetting');
        }
        for (final setting in settings.entries) {
          final double testSetting = Setting(setting.key).toDouble;
          log.debug('as Double | ${setting.key}: $testSetting');
        }
        for (final setting in settings.entries) {
          final String testSetting = Setting(setting.key).toString();
          log.debug('as String | ${setting.key}: $testSetting');
        }
        expect(Setting('test_writable_setting_1111', onError: (err) => 111).toInt, 111);
        expect(Setting('test_writable_setting_1222', onError: (err) => -222).toInt, -222);
        expect(Setting('test_writable_setting_1.10', onError: (err) => 1.10).toDouble, 1.10);
        expect(Setting('test_writable_setting_2.22', onError: (err) => 2.22).toDouble, 2.22);
        expect(Setting('test_writable_setting_1234', onError: (err) => '1234').toString(), '1234');
        expect(Setting('test_writable_setting_2345', onError: (err) => '2345').toString(), '2345');
      }
    });
    test('valid writable data with factor', () async {
      const factors = [0.123, -0.123, 3.54, -5.12];
      for (final factor in factors) {
        for (final settings in validWritableMaps) {
          await AppSettings.initialize(writable: FakeJsonMap(Ok(settings)));
          for (final setting in settings.entries) {
            final int testSetting = Setting(setting.key, factor: factor).toInt;
            log.debug('as Int | ${setting.key} * $factor: $testSetting');
          }
          for (final setting in settings.entries) {
            final double testSetting = Setting(setting.key, factor: factor).toDouble;
            log.debug('as Double | ${setting.key} * $factor: $testSetting');
          }
          const factorConst = 0.123;
          const setting = Setting('test_writable_setting_1', factor: factorConst);
          expect(setting.toInt, (settings['test_writable_setting_1']! * factor).toInt());
          expect(Setting('test_writable_setting_1', factor: factor).toInt, (settings['test_writable_setting_1']! * factor).toInt());
          expect(Setting('test_writable_setting_2', factor: factor).toInt, (settings['test_writable_setting_2']! * factor).toInt());
          expect(Setting('test_writable_setting_3', factor: factor).toInt, (settings['test_writable_setting_3']! * factor).toInt());
          expect(Setting('test_writable_setting_1', factor: factor).toDouble, (settings['test_writable_setting_1']! * factor).toDouble());
          expect(Setting('test_writable_setting_2', factor: factor).toDouble, (settings['test_writable_setting_2']! * factor).toDouble());
          expect(Setting('test_writable_setting_3', factor: factor).toDouble, (settings['test_writable_setting_3']! * factor).toDouble());
        }
      }
    });
    test('does not throw with invalid map', () {
      final invalidJsonMaps = [
        FakeJsonMap(Err(Failure(
          message: 'error',
          stackTrace: StackTrace.current,
        ))),
        FakeJsonMap(Err(Failure(
          message: null,
          stackTrace: StackTrace.current,
        ))),
        FakeJsonMap(Err(Failure(
          message: '{"validJson":true}',
          stackTrace: StackTrace.current,
        ))),
      ];
      for (final invalidJsonMap in invalidJsonMaps) {
        expectLater(
          AppSettings.initialize(writable: invalidJsonMap),
          completes,
        );
        expectLater(
          AppSettings.initialize(readOnly: invalidJsonMap, writable: invalidJsonMap),
          completes,
        );
      }
    });
  });
}
