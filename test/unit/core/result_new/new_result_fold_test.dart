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
    int onError(Failure error) => valueIfError;
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
  });
}