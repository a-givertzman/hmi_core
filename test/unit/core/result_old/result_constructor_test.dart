// ignore_for_file: deprecated_member_use_from_same_package
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_result_old.dart';

void main() {
  group('Result constructor', () {
    test('asserts if no args', () {
      expect(() => Result(), throwsA(isA<AssertionError>()));
    });
    test('completes if data is provided', () {
      expect(() => const Result(data: 'test'), returnsNormally);
    });
    test('completes if error is provided', () {
      expect(
        () => Result(
          error: Failure(message: '', stackTrace: StackTrace.current),
        ), 
        returnsNormally,
      );
    });
  });
}