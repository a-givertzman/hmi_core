import 'package:hmi_core/hmi_core.dart' hide Result;
import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Adapter for each variant
extension Adapter<V, E> on Result<V, E> {
  ///
  /// Converts from `Result<V, E>` to `Option<T>`.
  ///
  /// Converts `this` into an [Option], consuming `this`,
  /// and discarding the error, if any.
  Option<V> ok() {
    return switch (this) {
      Ok(:final V value) => Some(value),
      Err() => const None() as Option<V>,
    };
  }
  ///
  /// Converts from `Result<U, E>` to `Option<E>`.
  ///
  /// Converts `this` into an [Option], consuming `this`,
  /// and discarding the success value, if any.
  Option<E> err() {
    return switch (this) {
      Ok() => const None() as Option<E>,
      Err(:final error) => Some(error),
    };
  }
}
