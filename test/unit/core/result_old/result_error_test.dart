// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_result_old.dart';

void main() {
  group('Result error', () {
    const resultWithData = Result(data: 'test');
    final resultWithError = Result(
      error: Failure(message: '', stackTrace: StackTrace.current),
    );
    test('throws if object created without error', () {
      expect(() => resultWithData.error, throwsA(isA<Exception>()));
    });
    test('returns normally if object created with error', () {
      expect(() => resultWithError.error, returnsNormally);
    });
  });
}