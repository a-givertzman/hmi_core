import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_option.dart';
import 'test_data.dart';

void main() {
  group('Option is Some', () {
    test('returns true if it is instance of Some', () {
      for(final value in testData) {
        final Option option = Some(value);
        expect(option is Some, equals(true));
      }
    });
    test('returns false if it is instance of None', () {
      const Option option = None();
      expect(option is Some, equals(false));
    });
  });
}