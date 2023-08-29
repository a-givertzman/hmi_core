import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/value_object/value_string.dart';
import 'package:hmi_core/src/core/value_object/value_validation.dart';
import '../fake_value_validation.dart';

void main() {
  group('ValueString valid()', () {
    const providedValues = [
      'test1',
      'abcdef',
      '1234567',
      '312acd22',
      '!@#\$%^&*()_+=-?<>,./\\|',
    ];
    test('returns empty string if no validations provided', () {
      for(final providedValue in providedValues) {
        final valueString = ValueString(providedValue);
        expect(valueString.valid(), equals(''));
      }
    });
    test('returns string with validation messages separated by "; " if any validation provided', () {
      const providedValues = [
        {
          'valueStringParam': 'test1',
          'validations': [FakeValueValidation(message: '123')],
          'resultMessage': '123',
        },
        {
          'valueStringParam': 'abcdef',
          'validations': [
            FakeValueValidation(message: '1'), 
            FakeValueValidation(message: '2'), 
            FakeValueValidation(message: '3'),
          ],
          'resultMessage': '1; 2; 3',
        },
        {
          'valueStringParam': '1234567',
          'validations': [
            FakeValueValidation(message: 'message1'), 
            FakeValueValidation(message: 'message2'), 
          ],
          'resultMessage': 'message1; message2',
        },
        {
          'valueStringParam': '312acd22',
          'validations': [
            FakeValueValidation(message: 'a1'), 
            FakeValueValidation(message: '!@#\$%^&*()_+=-?<>,./\\|'), 
          ],
          'resultMessage': 'a1; !@#\$%^&*()_+=-?<>,./\\|',
        },
        {
          'valueStringParam': 'uoikmn',
          'validations': [],
          'resultMessage': '',
        },
        {
          'valueStringParam': '!@#\$%^&*()_+=-?<>,./\\|',
          'validations': [
            FakeValueValidation(message: ';;;'), 
            FakeValueValidation(message: ';;;;;'),
            FakeValueValidation(message: ';;;;;;;'),
          ],
          'resultMessage': ';;;; ;;;;;; ;;;;;;;',
        },
      ];
      for(final entry in providedValues) {
        final valueStringParam = entry['valueStringParam']! as String;
        final validations = (entry['validations']! as List).cast<ValueValidation>();
        final resultMessage = entry['resultMessage']! as String;
        final valueString = ValueString(
          valueStringParam, 
          validationList: validations,
        );
        expect(valueString.valid(), equals(resultMessage));
      }
    });
  });
}