import 'package:hmi_core/hmi_core_result_new.dart';
///
extension Querying<V, E> on Result<V, E> {
  ///
  bool isOk() {
    return switch (this) {
      Ok() => true,
      Err() => false,
    };
  }
  ///
  bool isOkAnd(bool Function(V value) f) {
    return switch (this) {
      Ok(:final V value) => f(value),
      Err() => false,
    };
  }
  ///
  bool isErr() {
    return switch (this) {
      Ok() => false,
      Err() => true,
    };
  }
  ///
  bool isErrAnd(bool Function(E error) f) {
    return switch (this) {
      Ok() => false,
      Err(:final E error) => f(error),
    };
  }
}
