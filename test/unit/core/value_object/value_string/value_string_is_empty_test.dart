import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/value_object/value_string.dart';

void main() {
  group('ValueString isEmpty()', () {
    test('returns true if underlying string is empty', () {
      expect(const ValueString('').isEmpty(), isTrue);
    });
    test('returns false if underlying string is not empty', () {
      const providedValues = [
        'test1',
        'abcdef',
        '1234567',
        '312acd22',
        '!@#\$%^&*()_+=-?<>,./\\|',
      ];
      for(final providedValue in providedValues) {
        expect(ValueString(providedValue).isEmpty(), isFalse);
      }
    });
  });
  
}