// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_result_old.dart';

void main() {
  group('Result hasError', () {
    const resultWithData = Result(data: 'test');
    final resultWithError = Result(
      error: Failure(message: '', stackTrace: StackTrace.current),
    );
    test('returns true if error is provided', () {
      expect(resultWithError.hasError, true);
    });
    test('returns false if no error', () {
      expect(resultWithData.hasError, false);
    });
  });
}