import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Querying the contained values
extension Querying<V, E> on Result<V, E> {
  ///
  /// Returns `true` if the result is [Ok], and `false` otherwise.
  ///
  /// ### Examples
  /// ```dart
  /// final Result<int, String> x = Ok(-3);
  /// x.isOk(); // true
  ///
  /// final Result<int, String> y = Err("Some error here");
  /// y.isOk(); // false
  /// ```
  bool isOk() {
    return switch (this) {
      Ok() => true,
      Err() => false,
    };
  }
  ///
  /// Returns `true` if the result is [Ok] and the value inside of it
  /// matches a predicate [f].
  ///
  /// Returns `false` otherwise.
  ///
  /// ### Examples
  /// ```dart
  /// final Result<int, String> x = Ok(2);
  /// x.isOkAnd((x) => x > 0); // true
  ///
  /// final Result<int, String> y = Ok(0);
  /// y.isOkAnd((y) => y > 0); // false
  ///
  /// final Result<int, String> z = Err("hey");
  /// z.isOkAnd((z) => z > 0); // false
  /// ```
  bool isOkAnd(bool Function(V value) f) {
    return switch (this) {
      Ok(:final V value) => f(value),
      Err() => false,
    };
  }
  ///
  /// Returns `true` if the result is [Err], and `false` otherwise.
  ///
  /// ### Examples
  /// ```dart
  /// final Result<int, String> x = Ok(-3);
  /// x.isErr(); // false
  ///
  /// final Result<int, String> y = Err("Some error here");
  /// y.isErr(); // true
  /// ```
  bool isErr() {
    return switch (this) {
      Ok() => false,
      Err() => true,
    };
  }
  ///
  /// Returns `true` if the result is [Err] and the value inside of it
  /// matches a predicate [f].
  ///
  /// Returns `false` otherwise.
  ///
  /// ### Examples
  /// ```dart
  /// final Result<int, String> x = Ok(-3);
  /// x.isErrAnd((e) => e.length > 0); // false
  ///
  /// final Result<int, String> y = Err("Some error here");
  /// y.isErrAnd((e) => e.length > 0); // true
  ///
  /// final Result<int, String> z = Err("");
  /// z.isErrAnd((e) => e.length > 0); // false
  /// ```
  bool isErrAnd(bool Function(E error) f) {
    return switch (this) {
      Ok() => false,
      Err(:final E error) => f(error),
    };
  }
}
