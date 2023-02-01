abstract class ValueValidation<T> {
  final String message;
  const ValueValidation({
    required this.message,
  });
  String validate(T value) {
    return message;
  }
}
