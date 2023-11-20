import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_option.dart';

class ForTestOptionOnly {
  final String value;
  ForTestOptionOnly(this.value);
}

void main() {
  group('Option fold strong typed', () {
    test('calls onSome function if it is instance of Some', () {
      for(int i=-50; i<=50; i++) {
        final Option<int> option = Some(i);
        final foldResult = switch(option) {
          Some<int>(:final value) => '$value',
          None() => 'None',
        };
        expect(foldResult, equals('$i'));
      }
    });
    test('calls onNone function if it is instance of None', () {
      const Option<int> option = None();
      final foldResult = switch(option) {
        Some<int>(:final value) => '$value',
        None() => 'None',
      };
      expect(foldResult, equals('None'));
    });
  });
  group('Option fold different types', () {
    final testData = [
      0x7FFFFFFFFFFFFFFF,
      -0x8000000000000000,
      ForTestOptionOnly("value"),
      true,
      false,
      double.maxFinite,
      double.minPositive
      -double.maxFinite,
    ];
    test('calls onSome function if it is instance of Some', () {
      for(final value in testData) {
        final Option option = Some(value);
        final foldResult = switch(option) {
          Some(:final value) => value,
          None() => None,
        };
        expect(foldResult, equals(value));
      }
    });
    test('calls onNone function if it is instance of None', () {
      const Option option = None();
      final foldResult = switch(option) {
        Some(:final value) => value,
        None() => None,
      };
      expect(foldResult, equals(None));
    });
  });
}




