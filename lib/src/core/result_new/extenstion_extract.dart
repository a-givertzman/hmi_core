import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Extracting contained values
extension Extract<V, E> on Result<V, E> {
  ///
  /// Returns the contained [Ok] value or a provided default value [d].
  ///
  /// Arguments passed to [unwrapOr] are eagerly evaluated; if you are passing
  /// the result of a function call, it is recommended to use [unwrapOrElse],
  /// which is lazily evaluated.
  V unwrapOr(V d) {
    return switch (this) {
      Ok(:final V value) => value,
      Err() => d,
    };
  }
  ///
  /// Returns the contained [Ok] value or computes it from a closure [d].
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
  E intoErr() {
    return (this as Err).error;
  }
}
