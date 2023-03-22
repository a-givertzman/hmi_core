part of 'option.dart';
///
class Some<T> implements Option<T> {
  final T _value;
  ///
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