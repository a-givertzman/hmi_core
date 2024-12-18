// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_result_old.dart';

void main() {
  group('Result fold', () {
    const resultWithData = Result(data: 'test');
    final resultWithError = Result(
      error: Failure(message: '', stackTrace: StackTrace.current),
    );
    final resultWithDataAndError = Result(
      data: 'test',
      error: Failure(message: '', stackTrace: StackTrace.current),
    );
    const valueIfData = 1;
    const valueIfError = 0;
    int onData<T>(T data) => valueIfData;
    int onError(Failure error) => valueIfError;
    test('calls onData if data is provided', () {
      expect(resultWithData.fold(onData: onData, onError: onError), valueIfData);
    });
    test('calls onError if no data', () {
      expect(resultWithError.fold(onData: onData, onError: onError), valueIfError);
    });
    test('calls onData if both data and error are provided', () {
      expect(resultWithDataAndError.fold(onData: onData, onError: onError), valueIfData);
    });
  });
}