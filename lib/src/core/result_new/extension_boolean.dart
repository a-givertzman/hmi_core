import 'package:hmi_core/hmi_core_result_new.dart';
///
extension Boolean<V, E> on Result<V, E> {
  ///
  Result<U, E> and<U>(Result<U, E> result) {
    return switch (this) {
      Ok() => result,
      Err(:final error) => Err(error),
    };
  }
  ///
  Result<U, E> andThen<U>(Result<U, E> Function(V value) f) {
    return switch (this) {
      Ok(:final value) => f(value),
      Err(:final error) => Err(error),
    };
  }
  ///
  Result<V, E> or(Result<V, E> result) {
    return switch (this) {
      Ok(:final value) => Ok(value),
      Err() => result,
    };
  }
  ///
  Result<V, E> orElse(Result<V, E> Function(E error) f) {
    return switch (this) {
      Ok(:final value) => Ok(value),
      Err(:final error) => f(error),
    };
  }
}
