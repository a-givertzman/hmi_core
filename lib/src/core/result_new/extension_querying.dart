import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Querying the contained values
extension Querying<V, E> on Result<V, E> {
  ///
  /// Returns `true` if the result is [Ok], and `false` otherwise.
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
  bool isOkAnd(bool Function(V value) f) {
    return switch (this) {
      Ok(:final V value) => f(value),
      Err() => false,
    };
  }
  ///
  /// Returns `true` if the result is [Err], and `false` otherwise.
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
  bool isErrAnd(bool Function(E error) f) {
    return switch (this) {
      Ok() => false,
      Err(:final E error) => f(error),
    };
  }
}
