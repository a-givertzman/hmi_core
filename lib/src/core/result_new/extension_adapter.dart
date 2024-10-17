import 'package:hmi_core/hmi_core.dart' hide Result;
import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Adapter for each variant
extension Adapter<V, E> on Result<V, E> {
  ///
  /// Converts from `Result<V, E>` to `Option<V>`.
  ///
  /// Converts `this` into an [Option], consuming `this`,
  /// and discarding the error, if any.
  ///
  /// ### Examples
  /// ```dart
  /// final Result<int, String> x = Ok(2);
  /// x.ok(); // Some(2)
  ///
  /// final Result<int, String> y = Err("Nothing here");
  /// y.ok(); // None
  /// ```
  Option<V> ok() {
    const Option<V> noneResult = None();
    return switch (this) {
      Ok(:final V value) => Some(value),
      Err() => noneResult,
    };
  }
  ///
  /// Converts from `Result<V, E>` to `Option<E>`.
  ///
  /// Converts `this` into an [Option], consuming `this`,
  /// and discarding the success value, if any.
  ///
  /// ### Examples
  /// ```dart
  /// final Result<int, String> x = Ok(2);
  /// x.err(); // None
  ///
  /// final Result<int, String> y = Err("Nothing here");
  /// y.err(); // Some("Nothing here")
  /// ```
  Option<E> err() {
    const Option<E> noneResult = None();
    return switch (this) {
      Ok() => noneResult,
      Err(:final error) => Some(error),
    };
  }
}
