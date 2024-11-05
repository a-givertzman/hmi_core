import 'package:hmi_core/src/core/error/failure.dart';
/// 
/// Containing either value of type [V] or error of type [E]
sealed class Result<V, E> {}
///
/// Containing either value of type [V] or [Failure]
typedef ResultF<V> = Result<V, Failure>;
/// 
/// Successful [Result] with [value].
final class Ok<V, E> implements Result<V, E> {
  final V value;
  /// Successful [Result] with [value].
  const Ok(this.value);
  //
  //
  @override
  int get hashCode => value.hashCode;
  //
  //
  @override
  bool operator ==(Object other) {
    return (other is Ok<V, E>) && (other.hashCode == hashCode);
  }
  //
  //
  @override
  String toString() {
    return '$runtimeType($value)';
  }
}
/// 
/// Unsuccessful [Result] with [error].
final class Err<V, E> implements Result<V, E> {
  final E error;
  /// Unsuccessful [Result] with [error].
  const Err(this.error);
  //
  //
  @override
  int get hashCode => error.hashCode;
  //
  //
  @override
  bool operator ==(Object other) {
    return (other is Err<V, E>) && (other.hashCode == hashCode);
  }
  //
  //
  @override
  String toString() {
    return '$runtimeType($error)';
  }
}
