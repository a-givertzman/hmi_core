part of 'option.dart';
/// [Option] that holds some value.
class Some<T> implements Option<T> {
  final T _value;
  ///
  /// Create [Option] object that holds some [value].
  const Some(T value) : _value = value;
  //
  @override
  R fold<R>({
    required R Function(T v) onSome, 
    required R Function() onNone,
  }) => onSome(_value);
  //
  @override
  bool get isNone => false;
  //
  @override
  bool get isSome => true;
}