import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/error/failure.dart';

void main() {
  test('Failure .toString() serializes correctly', () {
    const errorMessages = [
      '132'
      '',
      null,
      1,
      23.4,
      true,
    ];
    for(final message in errorMessages) {
       expect(
        Failure(
          message: message, 
          stackTrace: StackTrace.current,
        ).toString(),
        equals(message.toString()),
      );
    }
  });
}