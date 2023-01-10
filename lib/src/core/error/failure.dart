/// Basic failure with chaining support.
/// Example:
/// ```
/// const Failure(
///   message: 'Outer message',
///   failure: const Failure(
///      message: 'Inner message',
///   ),
/// );
/// ```
class Failure implements Exception {
  final String message;
  final StackTrace? stackTrace;
  final Failure? failure;
  const Failure({
    required this.message,
    this.stackTrace,
    this.failure,
  });

  @override
  String toString() {
    final subfailureString = (failure != null) 
      ? '\n\tsubfailure: ${failure.toString()}' : '';
    return '$Failure: $message' + subfailureString;
  }
}