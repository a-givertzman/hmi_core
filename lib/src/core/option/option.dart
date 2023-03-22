part 'some.dart';
part 'none.dart';
/// 
/// Holds either value or nothing.
abstract class Option<T> {
  /// 
  /// Creates object that holds some [value].
  const factory Option.some(T value) = Some<T>;
  /// 
  /// Creates object that holds nothing.
  const factory Option.none() = None<T>;
  /// 
  /// Returns value of type [R] based on condition 
  /// that object is holding some value or not.
  /// 
  /// Example interpetations of provided function:
  ///   - [onSome] - transforms holded value to another of type [R],
  ///   - [onNone] - returns default of type [R].
  R fold<R>({
    required R Function(T v) onSome,
    required R Function() onNone,
  });
  ///
  /// Is object holding some value?
  bool get isSome;
  /// Is object holding nothing?
  bool get isNone;
}