import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_result_new.dart';

void main() {
  group('Result fold', () {
    const Result<String,Failure> resultWithData = Ok('test');
    final Result<String,Failure> resultWithError = Err(
      Failure(message: '', stackTrace: StackTrace.current),
    );
    const valueIfData = 1;
    const valueIfError = 0;
    int onData<T>(T data) => valueIfData;
    int onError<T>(T error) => valueIfError;
    test('calls onData if data is provided', () {
      final foldResult = switch(resultWithData) {
        Ok(:final value) => onData(value),
        Err(:final error) => onError(error),
      };
      expect(foldResult, valueIfData);
    });
    test('calls onError if no data', () {
      final foldResult = switch(resultWithError) {
        Ok(:final value) => onData(value),
        Err(:final error) => onError(error),
      };
      expect(foldResult, valueIfError);
    });
    test('works perfectly even if data is void', () {
      const Result<void, void> result = Ok(null);
      final foldResult = switch(result) {
        Ok(:final value) => onData(value),
        Err(:final error) => onError(error),
      };
      expect(foldResult, valueIfData);
    });
    test('works perfectly even if error is void', () {
      const Result<void, void> result = Err(null);
      final foldResult = switch(result) {
        Ok(:final value) => onData(value),
        Err(:final error) => onError(error),
      };
      expect(foldResult, valueIfError);
    });
  });
}