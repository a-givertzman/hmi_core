part 'some.dart';
part 'none.dart';
///
abstract class Option<T> {
  ///
  const factory Option.some(T v) = Some;
  ///
  const factory Option.none() = None;
  ///
  R fold<R>({
    required R Function(T v) onSome,
    required R Function() onNone,
  });
  ///
  bool get isSome;
  ///
  bool get isNone;
}