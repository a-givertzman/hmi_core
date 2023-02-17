import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_log.dart';
import 'package:hmi_core/hmi_core_relative_value.dart';

void main() {
  Log.initialize(level: LogLevel.all);
  const log = Log('RelativeValueTest');
  group('RelativeValueTest', () {
    // const _debug = true;
    setUp(() async {
      // TODO add implementation or remove this block
      // return 0;
      // WidgetsFlutterBinding.ensureInitialized();
      // SharedPreferences.setMockInitialValues({});
    });
    test('basis', () async {
      expect(
        RelativeValue(min: 0, max: 100),
        isInstanceOf<RelativeValue>(),
      );
      final basis = RelativeValue(basis: 1.333, min: 0, max: 100).basis;
      expect(basis, 1.333);
    });
    test('relative 0..100', () async {
      final relativeValue = RelativeValue(basis: 1, min: 0, max: 100);
      expect(
        relativeValue,
        isInstanceOf<RelativeValue>(),
      );
      for (int value = 0; value <= 100; value++) {
        final rValue = relativeValue.relative(value.toDouble());
        log.debug('value: $value\trelative: $rValue');
        expect(rValue.toStringAsFixed(2), (value / 100).toStringAsFixed(2));
      }
    });
    test('relative 100..200', () async {
      final relativeValue = RelativeValue(basis: 1, min: 100, max: 200);
      expect(
        relativeValue,
        isInstanceOf<RelativeValue>(),
      );
      for (int value = 100; value <= 200; value++) {
        final rValue = relativeValue.relative(value.toDouble());
        log.debug('value: $value\trelative: $rValue');
        expect(rValue.toStringAsFixed(2), ((value - 100)/ 100).toStringAsFixed(2));
      }
    });
  });
}
