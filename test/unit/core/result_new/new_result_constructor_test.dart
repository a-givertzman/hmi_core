import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_result_new.dart';

void main() {
  group('Result constructor of', () {
    test('Ok completes if data is provided', () {
      expect(() => const Ok('test'), returnsNormally);
    });
    test('Err completes if error is provided', () {
      expect(
        () => Err(
          Failure(message: '', stackTrace: StackTrace.current),
        ), 
        returnsNormally,
      );
    });
  });
}