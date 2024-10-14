import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Transforming contained values
extension Transform<V, E> on Result<V, E> {
  ///
  /// Maps a `Result<V, E>` to `Result<U, E>` by applying a function to a
  /// contained [Ok] value, leaving an [Err] value untouched.
  Result<U, E> map<U>(U Function(V value) op) {
    return switch (this) {
      Ok(:final V value) => Ok(op(value)),
      Err(:final E error) => Err(error),
    };
  }
  ///
  /// Maps a `Result<V, E>` to `U` by returning default value [d] (if the result is [Err]),
  /// or applying a function [f] to the contained value (if the result is [Ok]).
  U mapOr<U>(U d, U Function(V value) f) {
    return switch (this) {
      Ok(:final V value) => f(value),
      Err() => d,
    };
  }
  ///
  /// Maps a `Result<V, E>` to `U` by applying fallback function [d] to
  /// a contained [Err] value, or function [f] to a contained [Ok] value.
  U mapOrElse<U>(U Function(E value) d, U Function(V value) f) {
    return switch (this) {
      Ok(:final V value) => f(value),
      Err(:final E error) => d(error),
    };
  }
  ///
  /// Maps a `Result<V, E>` to `Result<U, F>` by applying a function to a
  /// contained [Err] value, leaving an [Ok] value untouched.
  Result<V, F> mapErr<F>(F Function(E error) op) {
    return switch (this) {
      Ok(:final V value) => Ok(value),
      Err(:final E error) => Err(op(error)),
    };
  }
  ///
  /// Calls a function [f] with a reference to the contained value
  /// if the result is [Ok].
  Result<V, E> inspect(Function(V value) f) {
    if (this case Ok(:final value)) {
      f(value);
    }
    return this;
  }
  ///
  /// Calls a function [f] with a reference to the contained value
  /// if the result is [Err].
  Result<V, E> inspectErr(Function(E error) f) {
    if (this case Err(:final error)) {
      f(error);
    }
    return this;
  }
}
