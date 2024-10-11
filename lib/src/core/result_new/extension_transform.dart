import 'package:hmi_core/hmi_core_result_new.dart';
///
extension Transform<V, E> on Result<V, E> {
  ///
  Result<U, E> map<U>(U Function(V value) op) {
    return switch (this) {
      Ok(:final V value) => Ok(op(value)),
      Err(:final E error) => Err(error),
    };
  }
  ///
  U mapOr<U>(U d, U Function(V value) f) {
    return switch (this) {
      Ok(:final V value) => f(value),
      Err() => d,
    };
  }
  ///
  U mapOrElse<U>(U Function(E value) d, U Function(V value) f) {
    return switch (this) {
      Ok(:final V value) => f(value),
      Err(:final E error) => d(error),
    };
  }
  ///
  Result<V, E> inspect(Function(V value) f) {
    if (this case Ok(:final value)) {
      f(value);
    }
    return this;
  }
  ///
  Result<V, E> inspectErr(Function(E error) f) {
    if (this case Err(:final error)) {
      f(error);
    }
    return this;
  }
}
