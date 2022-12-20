import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_result.dart';

void main() {
  group('Result', () {
    final resultWithData = Result(data: 'test');
    final resultWithError = Result(
      error: Failure(message: '', stackTrace: StackTrace.current),
    );
    final resultWithDataAndError = Result(
      data: 'test',
      error: Failure(message: '', stackTrace: StackTrace.current),
    );
    group('constructor', () {
      test('asserts if no args', () {
        expect(() => Result(), throwsA(isA<AssertionError>()));
      });
      test('completes if data is provided', () {
        expect(() => Result(data: 'test'), returnsNormally);
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
    group('data', () {
      test('throws if no data', () {
        expect(() => resultWithError.data, throwsA(isA<Exception>()));
      });
      test('returns if data is provided', () {
        expect(() => resultWithData.data, returnsNormally);
      });
    });
    group('error', () {
      test('throws if no error', () {
        expect(() => resultWithData.error, throwsA(isA<Exception>()));
      });
      test('returns if error is provided', () {
        expect(() => resultWithError.error, returnsNormally);
      });
    });
    group('hasData', () {
      test('returns true if data is provided', () {
        expect(resultWithData.hasData, true);
      });
      test('returns false if no data', () {
        expect(resultWithError.hasData, false);
      });
    });
    group('hasError', () {
      test('returns true if error is provided', () {
        expect(resultWithError.hasError, true);
      });
      test('returns false if no error', () {
        expect(resultWithData.hasError, false);
      });
    });
    group('fold', () {
      const valueIfData = 1;
      const valueIfError = 0;
      int onData<T>(T data) => valueIfData;
      int onError(Failure error) => valueIfError;
      test('calls onData if data is provided', () {
        expect(resultWithData.fold(onData, onError), valueIfData);
      });
      test('calls onError if no data', () {
        expect(resultWithError.fold(onData, onError), valueIfError);
      });
      test('calls onData if both data and error are provided', () {
        expect(resultWithDataAndError.fold(onData, onError), valueIfData);
      });
    });
  });
}