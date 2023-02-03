// ignore_for_file: use_setters_to_change_properties

abstract class ValueObject<T> {
  final T _v;
  const ValueObject(T value) : _v = value;
  ValueObject<T> toDomain(String value);
  /// returns current internal value of the ValueObject
  /// if was created ValueObject<Int>(123), then value returns 123
  /// or you can override it behavior
  T get value => _v;
  @override
  bool operator ==(Object other) {
    if (other is ValueObject) {
      return other.value == _v;
    }
    return false;
  }
  @override
  int get hashCode => _v.hashCode;
}
