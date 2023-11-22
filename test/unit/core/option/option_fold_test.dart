import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_option.dart';
import 'test_data.dart';

void main() {
  group('Option fold strong typed', () {
    test('calls onSome function if it is instance of Some', () {
      for(int i=-50; i<=50; i++) {
        final Option<int> option = Some(i);
        final foldResult = switch(option) {
          Some<int>(:final value) => value,
          None() => null,
        };
        expect(foldResult, equals(i));
      }
    });
    test('calls onNone function if it is instance of None', () {
      const Option<int> option = None();
      final foldResult = switch(option) {
        Some<int>(:final value) => value,
        None() => null,
      };
      expect(foldResult, equals(null));
    });
  });
  group('Option fold different types', () {
    test('calls onSome function if it is instance of Some', () {
      for(final value in testData) {
        final Option option = Some(value);
        final foldResult = switch(option) {
          Some(:final value) => value,
          None() => null,
        };
        expect(foldResult, equals(value));
      }
    });
    test('calls onNone function if it is instance of None', () {
      const Option option = None();
      final foldResult = switch(option) {
        Some(:final value) => value,
        None() => null,
      };
      expect(foldResult, equals(null));
    });
  });
}
