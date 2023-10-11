import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_result_new.dart';

void main() {   
  group('Result is', () {
    const Result<String, Failure> resultWithData = Ok('test');
    final Result<String, Failure> resultWithError = Err(
      Failure(message: '', stackTrace: StackTrace.current),
    );
    test('Ok returns true if data is provided', () {
      expect(resultWithData is Ok, isTrue);

    });
    test('Err returns false if data is provided', () {
      expect(resultWithData is Err, isFalse);

    });
    test('Ok returns false if error is provided', () {
      expect(resultWithError is Ok, isFalse);
    });
    test('Err returns true if error is provided', () {
      expect(resultWithError is Err, isTrue);
    });
  });
}