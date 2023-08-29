import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/value_object/value_string.dart';

void main() {
  test('ValueString toString() returns provided value', () {
    const providedValues = [
      'test1',
      'abcdef',
      '1234567',
      '312acd22',
      '!@#\$%^&*()_+=-?<>,./\\|',
    ];
    for(final providedValue in providedValues) {
      final valueString = ValueString(providedValue);
      expect(valueString.toString(), equals(providedValue));
    }
  });
}