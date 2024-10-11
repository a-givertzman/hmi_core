import 'package:hmi_core/hmi_core_result_new.dart';
///
extension Extract<V, E> on Result<V, E> {
  ///
  V unwrapOr(V d) {
    return switch (this) {
      Ok(:final V value) => value,
      Err() => d,
    };
  }
  ///
  V unwrapOrElse(V Function(E error) d) {
    return switch (this) {
      Ok(:final V value) => value,
      Err(:final E error) => d(error),
    };
  }
  ///
  E unwrapErrOr(E d) {
    return switch (this) {
      Ok() => d,
      Err(:final E error) => error,
    };
  }
  ///
  E unwrapErrOrElse(E Function(V value) d) {
    return switch (this) {
      Ok(:final V value) => d(value),
      Err(:final E error) => error,
    };
  }
}
