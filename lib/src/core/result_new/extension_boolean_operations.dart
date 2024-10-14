import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Boolean operations on the values, eager and lazy
extension BooleanOperations<V, E> on Result<V, E> {
  ///
  /// Returns [result] if the result is [Ok], otherwise returns the [Err] value of `this`.
  ///
  /// Arguments passed to [and] are eagerly evaluated; if you are passing the
  /// result of a function call, it is recommended to use [andThen], which is
  /// lazily evaluated.
  Result<U, E> and<U>(Result<U, E> result) {
    return switch (this) {
      Ok() => result,
      Err(:final error) => Err(error),
    };
  }
  ///
  /// Calls [op] if the result is [Ok], otherwise returns the [Err] value of `this`.
  ///
  /// This function can be used for control flow based on [Result] values.
  ///
  /// Often used to chain fallible operations that may return [Err].
  Result<U, E> andThen<U>(Result<U, E> Function(V value) op) {
    return switch (this) {
      Ok(:final value) => op(value),
      Err(:final error) => Err(error),
    };
  }
  ///
  /// Returns [result] if the result is [Err], otherwise returns the [Ok] value of `this`.
  ///
  /// Arguments passed to [or] are eagerly evaluated; if you are passing the
  /// result of a function call, it is recommended to use [orElse], which is
  /// lazily evaluated.
  Result<V, E> or(Result<V, E> result) {
    return switch (this) {
      Ok(:final value) => Ok(value),
      Err() => result,
    };
  }
  ///
  /// Calls [op] if the result is [Err], otherwise returns the [Ok] value of `this`.
  ///
  /// This function can be used for control flow based on [Result] values.
  Result<V, E> orElse(Result<V, E> Function(E error) f) {
    return switch (this) {
      Ok(:final value) => Ok(value),
      Err(:final error) => f(error),
    };
  }
}
