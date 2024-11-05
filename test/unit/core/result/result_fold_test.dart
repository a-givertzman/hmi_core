import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_result.dart';
import 'test_data.dart';

void main() {
  group('Result fold', () {
    test('matches Ok if data is provided', () {
      for (final value in testData) {
        final Result<dynamic, Failure> result = Ok(value);
        final foldResult = switch(result) {
          Ok(:final value) => value,
          Err(:final error) => error,
        };
        expect(foldResult, value);
      }
    });
    test('matches Err if no data', () {
      for (final error in testData) {
        final Result result = Err(error);
        final foldResult = switch(result) {
          Ok(:final value) => value,
          Err(:final error) => error,
        };
        expect(foldResult, error);
      }
    });
    test('works perfectly even if data is void', () {
      for (final value in testData) {
        // ignore: void_checks
        final Result<void, Failure> result = Ok(value);
        expect(
          () {
            return switch(result) {
              Ok(:final value) => value,
              Err(:final error) => error,
            };
          },
          returnsNormally,
        );
      }
    });
    test('works perfectly even if error is void', () {
      for (final error in testData) {
        // ignore: void_checks
        final Result<dynamic, void> result = Err(error);
        expect(
          () {
            return switch(result) {
              Ok(:final value) => value,
              Err(:final error) => error,
            };
          },
          returnsNormally,
        );
      }
    });
  });
}