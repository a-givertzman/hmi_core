part of 'option.dart';
/// [Option] that holds nothing.
class None<T> implements Option<T> {
  /// Create [Option] object that holds nothing.
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