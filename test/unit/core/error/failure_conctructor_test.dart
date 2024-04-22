import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/error/failure.dart';

void main() {
  test('Failure creates normally', () {
    expect(
      () => Failure(
        message: '', 
        stackTrace: StackTrace.current,
      ), 
      returnsNormally,
    );
    expect(
      () => Failure.dataSource(
        message: '', 
        stackTrace: StackTrace.current,
      ), 
      returnsNormally,
    );
    expect(
      () => Failure.dataObject(
        message: '', 
        stackTrace: StackTrace.current,
      ), 
      returnsNormally,
    );
    expect(
      () => Failure.dataCollection(
        message: '', 
        stackTrace: StackTrace.current,
      ), 
      returnsNormally,
    );
    expect(
      () => Failure.auth(
        message: '', 
        stackTrace: StackTrace.current,
      ), 
      returnsNormally,
    );
    expect(
      () => Failure.convertion(
        message: '', 
        stackTrace: StackTrace.current,
      ), 
      returnsNormally,
    );
    expect(
      () => Failure.connection(
        message: '', 
        stackTrace: StackTrace.current,
      ), 
      returnsNormally,
    );
    expect(
      () => Failure.translation(
        message: '', 
        stackTrace: StackTrace.current,
      ), 
      returnsNormally,
    );
    expect(
      () => Failure.unexpected(
        message: '', 
        stackTrace: StackTrace.current,
      ), 
      returnsNormally,
    );
  });
}