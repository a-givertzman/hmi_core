part of 'option.dart';
///
class None<T> implements Option<T> {
  ///
  const None();
  //
  @override
  R fold<R>({
    required R Function(T v) onSome, 
    required R Function() onNone,
  }) => onNone();
  //
  @override
  bool get isNone => true;
  //
  @override
  bool get isSome => false;
}