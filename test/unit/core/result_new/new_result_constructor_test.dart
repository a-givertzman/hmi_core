import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_result_new.dart';

import 'test_data.dart';

void main() {
  group('Result constructor of', () {
    test('Ok completes if data is provided', () {
      for(final value in testData) {
        expect(() => Ok(value), returnsNormally);
      }
    });
    test('Err completes if error is provided', () {
      for(final value in testData) {
        expect(
          () => Err(
            Failure(message: value, stackTrace: StackTrace.current),
          ), 
          returnsNormally,
        );
      }
    });
  });
}