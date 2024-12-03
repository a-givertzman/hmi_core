import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_option.dart';
///
/// Extracting contained values
extension OptionExtract<V> on Option<V> {
  ///
  /// Returns the contained [Some] value, consuming the `self` value.
  ///
  /// Because this function may panic, its use is generally discouraged.
  /// Instead, prefer to use pattern matching and handle the [`None`]
  /// case explicitly, or call [`unwrap_or`], [`unwrap_or_else`], or
  /// [`unwrap_or_default`].
  ///
  /// [`unwrap_or`]: Option::unwrap_or
  /// [`unwrap_or_else`]: Option::unwrap_or_else
  /// [`unwrap_or_default`]: Option::unwrap_or_default
  ///
  /// Throws an [Failure] if the self value equals [`None`].
  ///
  /// # Examples
  ///
  /// ```dart
  /// final Option<int> x = Ok(2);
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
      Some(:final V value) => value,
      None() => throw Failure(
          message: "Called unwrap() on None",
          stackTrace: StackTrace.current,
        ),
    };
  }
  ///
  /// Returns the contained [Some] value, consuming the `self` value.
  ///
  /// # Throws an error if the value is a [None] with a custom error message provided by
  /// `msg`.
  ///
  /// # Examples
  ///
  /// Basic usage:
  /// 
  /// ```dart
  /// final Option<int> x = Some(2);
  /// x.expect("A custom message"); // 2
  /// ```
  ///
  /// Should throw a Failure:
  /// 
  /// ```dart
  /// final Option<int> x = None();
  /// // throw Failure with message: "Testing expect: emergency failure"
  /// x.expect("Testing expect");
  /// ```
  V expect(String message) {
    return switch (this) {
      Some(:final V value) => value,
      None() => throw Failure(
          message: message,
          stackTrace: StackTrace.current,
        ),
    };
  }

  // ///
  // /// # Examples
  // ///
  // /// ```dart
  // /// final Option<int> = None();
  // /// x.unwrapErr(); // "emergency failure"
  // /// ```
  // /// 
  // /// Should throw a Failure:
  // /// 
  // /// ```dart
  // /// final Result<int, String> x = Ok(2);
  // /// // throw Failure with message: "Called unwrapErr() on Result with value: 2"
  // /// x.unwrapErr();
  // /// ```
  // E unwrapErr() {
  //   return switch (this) {
  //     Ok(:final V value) => throw Failure(
  //         message: "Called unwrapErr() on Result with value: $value",
  //         stackTrace: StackTrace.current,
  //       ),
  //     Err(:final E error) => error,
  //   };
  // }
  // ///
  // /// Returns the contained [Err] error, consuming the `this` value.
  // ///
  // /// ### Throws an error
  // ///
  // /// Throws an [Failure] if the value is an [Ok], with a failure message including the
  // /// passed message, and the content of the [Ok].
  // ///
  // ///
  // /// ### Examples
  // ///
  // /// Basic usage:
  // /// ```dart
  // /// final Result<int, String> x = Err("emergency failure");
  // /// x.expectErr("A custom message"); // "emergency failure"
  // /// ```
  // ///
  // /// Should throw a Failure:
  // /// ```dart
  // /// final Result<int, String> x = Ok(2);
  // /// // throw Failure with message: "Testing expectErr: 2"
  // /// x.expectErr("Testing expectErr");
  // /// ```
  // E expectErr(String message) {
  //   return switch (this) {
  //     Ok(:final V value) => throw Failure(
  //         message: "$message: $value",
  //         stackTrace: StackTrace.current,
  //       ),
  //     Err(:final E error) => error,
  //   };
  // }
  ///
  /// Returns the contained [Some] value or a provided default.
  ///
  /// Arguments passed to `unwrap_or` are eagerly evaluated; if you are passing
  /// the result of a function call, it is recommended to use [`unwrap_or_else`],
  /// which is lazily evaluated.
  ///
  /// ### Examples
  /// 
  /// ```dart
  /// final defaultValue = 2;
  /// final Option<int> x = Some(9);
  /// x.unwrapOr(defaultValue); // 9
  /// //
  /// final Option<int> y = None();
  /// y.unwrapOr(defaultValue); // 2
  /// ```
  V unwrapOr(V d) {
    return switch (this) {
      Some(:final V value) => value,
      None() => d,
    };
  }
  ///
  /// Returns the contained [`Some`] value or computes it from a closure.
  ///
  /// ### Examples
  /// 
  /// ```dart
  /// int onNone() => 'sNone';
  ///
  /// final Option<int> x = Some('isSome');
  /// x.unwrapOrElse(onNone); // 'isSome'
  ///
  /// final Option<int> y = None();
  /// y.unwrapOrElse(onNone); // 'isNone'
  /// ```
  V unwrapOrElse(V Function() d) {
    return switch (this) {
      Some(:final V value) => value,
      None() => d(),
    };
  }
}
// ///
// /// Extracting contained values for [Ok]
// extension ExtractOk<V> on Result<V, Never> {
//   ///
//   /// Returns the contained [Ok] value, but never throw an error.
//   ///
//   /// It can be used as a maintainability safeguard that will fail
//   /// to compile if the error type of the [Result] is later changed
//   /// from [Never] to a type that can actually occur.
//   ///
//   /// ### Examples
//   /// ```dart
//   /// Result<String, Never> onlyGoodNews() => Ok("this is fine");
//   /// onlyGoodNews().intoOk(); // "this is fine"
//   /// ```
//   V intoOk() {
//     return (this as Ok).value;
//   }
// }
// ///
// /// Extracting contained values for [Err]
// extension ExtractErr<E> on Result<Never, E> {
//   ///
//   /// Returns the contained [Err] value, but never throw an error.
//   ///
//   /// It can be used as a maintainability safeguard that will fail
//   /// to compile if the ok type of the [Result] is later changed
//   /// from [Never] to a type that can actually occur.
//   ///
//   /// ### Examples
//   /// ```dart
//   /// Result<String, Never> onlyBadNews() => Err("Oops, it failed");
//   /// onlyBadNews().intoErr(); // "Oops, it failed"
//   /// ```
//   E intoErr() {
//     return (this as Err).error;
//   }
// }
