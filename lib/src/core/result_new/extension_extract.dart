import 'package:hmi_core/hmi_core.dart' hide Result;
import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Extracting contained values
extension Extract<V, E> on Result<V, E> {
  ///
  /// Returns the contained [Ok] value, consuming the `this` value.
  ///
  /// Because this function may throw a [Failure], its use is generally discouraged.
  /// Instead, prefer to use pattern matching and handle the [Err]
  /// case explicitly, or call [unwrapOr], or [unwrapOrElse];
  ///
  /// ### Throws an error
  ///
  /// Throws an [Failure] if the value is an [Err], with a failure message provided by the
  /// [Err]'s value.
  ///
  /// ### Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// final Result<int, String> x = Ok(2);
  /// x.unwrap(); // 2
  /// ```
  ///
  /// Should throw a Failure:
  /// ```dart
  /// final Result<int, String> x = Err("emergency failure");
  /// // throw Failure with message: "Called unwrap() on Result with error: emergency failure"
  /// x.unwrap();
  /// ```
  V unwrap() {
    return switch (this) {
      Ok(:final V value) => value,
      Err(:final E error) => throw Failure(
          message: "Called unwrap() on Result with error: $error",
          stackTrace: StackTrace.current,
        ),
    };
  }
  ///
  /// Returns the contained [Ok] value, consuming the `this` value.
  ///
  /// Because this function may throw a [Failure], its use is generally discouraged.
  /// Instead, prefer to use pattern matching and handle the [Err]
  /// case explicitly, or call [unwrapOr], or [unwrapOrElse];
  ///
  /// ### Throws an error
  ///
  /// Throws an [Failure] if the value is an [Err], with a failure message including the
  /// passed [message], and the content of the [Err].
  ///
  /// ### Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// final Result<int, String> x = Ok(2);
  /// x.expect("A custom message"); // 2
  /// ```
  ///
  /// Should throw a Failure:
  /// ```dart
  /// final Result<int, String> x = Err("emergency failure");
  /// // throw Failure with message: "Testing expect: emergency failure"
  /// x.expect("Testing expect");
  /// ```
  V expect(String message) {
    return switch (this) {
      Ok(:final V value) => value,
      Err(:final E error) => throw Failure(
          message: "$message: $error",
          stackTrace: StackTrace.current,
        ),
    };
  }
  ///
  /// Returns the contained [Err] error, consuming the `this` value.
  ///
  /// ### Throws an error
  ///
  /// Throws an [Failure] if the value is an [Ok], with a custom failure message provided
  /// by the [Ok]'s value.
  ///
  /// ### Examples
  /// ```dart
  /// final Result<int, String> = Err("emergency failure");
  /// x.unwrapErr(); // "emergency failure"
  /// ```
  ///
  /// Should throw a Failure:
  /// ```dart
  /// final Result<int, String> x = Ok(2);
  /// // throw Failure with message: "Called unwrapErr() on Result with value: 2"
  /// x.unwrapErr();
  /// ```
  E unwrapErr() {
    return switch (this) {
      Ok(:final V value) => throw Failure(
          message: "Called unwrapErr() on Result with value: $value",
          stackTrace: StackTrace.current,
        ),
      Err(:final E error) => error,
    };
  }
  ///
  /// Returns the contained [Err] error, consuming the `this` value.
  ///
  /// ### Throws an error
  ///
  /// Throws an [Failure] if the value is an [Ok], with a failure message including the
  /// passed message, and the content of the [Ok].
  ///
  ///
  /// ### Examples
  ///
  /// Basic usage:
  /// ```dart
  /// final Result<int, String> x = Err("emergency failure");
  /// x.expectErr("A custom message"); // "emergency failure"
  /// ```
  ///
  /// Should throw a Failure:
  /// ```dart
  /// final Result<int, String> x = Ok(2);
  /// // throw Failure with message: "Testing expectErr: 2"
  /// x.expectErr("Testing expectErr");
  /// ```
  E expectErr(String message) {
    return switch (this) {
      Ok(:final V value) => throw Failure(
          message: "$message: $value",
          stackTrace: StackTrace.current,
        ),
      Err(:final E error) => error,
    };
  }
  ///
  /// Returns the contained [Ok] value or a provided default value [d].
  ///
  /// Arguments passed to [unwrapOr] are eagerly evaluated; if you are passing
  /// the result of a function call, it is recommended to use [unwrapOrElse],
  /// which is lazily evaluated.
  ///
  /// ### Examples
  /// ```dart
  /// final defaultValue = 2;
  /// final Result<int, String> x = Ok(9);
  /// x.unwrapOr(defaultValue); // 9
  ///
  /// final Result<int, String> y = Err("error");
  /// y.unwrapOr(defaultValue); // 2
  /// ```
  V unwrapOr(V d) {
    return switch (this) {
      Ok(:final V value) => value,
      Err() => d,
    };
  }
  ///
  /// Returns the contained [Ok] value or computes it from a closure [d].
  ///
  /// ### Examples
  /// ```dart
  /// int count(String s) => s.length;
  ///
  /// final Result<int, String> x = Ok(2);
  /// x.unwrapOrElse(count); // 2
  ///
  /// final Result<int, String> y = Err("foo");
  /// y.unwrapOrElse(count); // 3
  /// ```
  V unwrapOrElse(V Function(E error) d) {
    return switch (this) {
      Ok(:final V value) => value,
      Err(:final E error) => d(error),
    };
  }
}
///
/// Extracting contained values for [Ok]
extension ExtractOk<V> on Result<V, Never> {
  ///
  /// Returns the contained [Ok] value, but never throw an error.
  ///
  /// It can be used as a maintainability safeguard that will fail
  /// to compile if the error type of the [Result] is later changed
  /// from [Never] to a type that can actually occur.
  ///
  /// ### Examples
  /// ```dart
  /// Result<String, Never> onlyGoodNews() => Ok("this is fine");
  /// onlyGoodNews().intoOk(); // "this is fine"
  /// ```
  V intoOk() {
    return (this as Ok).value;
  }
}
///
/// Extracting contained values for [Err]
extension ExtractErr<E> on Result<Never, E> {
  ///
  /// Returns the contained [Err] value, but never throw an error.
  ///
  /// It can be used as a maintainability safeguard that will fail
  /// to compile if the ok type of the [Result] is later changed
  /// from [Never] to a type that can actually occur.
  ///
  /// ### Examples
  /// ```dart
  /// Result<String, Never> onlyBadNews() => Err("Oops, it failed");
  /// onlyBadNews().intoErr(); // "Oops, it failed"
  /// ```
  E intoErr() {
    return (this as Err).error;
  }
}
