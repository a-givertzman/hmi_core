import 'package:hmi_core/src/core/log/log.dart';

class Failure<T> {
  static const _log = Log('Failure');
  final T message;
///
/// Ganeral Failures
  Failure({
    required this.message, 
    required StackTrace stackTrace,
  }) {
    _log.warning(message, this, stackTrace);
  }
  //
  // dataSource failure
  factory Failure.dataSource({
    required T message,
    required StackTrace stackTrace,
  }) => Failure(message: message, stackTrace: stackTrace);
  //
  // dataObject failure
  factory Failure.dataObject({
    required T message,
    required StackTrace stackTrace,
  }) => Failure(message: message, stackTrace: stackTrace);
  //
  // dataCollection failure
  factory Failure.dataCollection({
    required T message,
    required StackTrace stackTrace,
  }) => Failure(message: message, stackTrace: stackTrace);
  //
  // auth failure
  factory Failure.auth({
    required T message,
    required StackTrace stackTrace,
  }) => Failure(message: message, stackTrace: stackTrace);
  //
  // convertion failure
  factory Failure.convertion({
    required T message,
    required StackTrace stackTrace,
  }) => Failure(message: message, stackTrace: stackTrace);
  //
  // Connection failure
  factory Failure.connection({
    required T message,
    required StackTrace stackTrace,
  }) => Failure(message: message, stackTrace: stackTrace);
  // Translation failure
  factory Failure.translation({
    required T message,
    required StackTrace stackTrace,
  }) => Failure(message: message, stackTrace: stackTrace);
  //
  // Unexpected failure
  factory Failure.unexpected({
    required T message,
    required StackTrace stackTrace,
  }) => Failure(message: message, stackTrace: stackTrace);

  @override
  String toString() {
    return message.toString();
  }
}
