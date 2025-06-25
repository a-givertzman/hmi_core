import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/error/failure.dart';

void main() {
  test('Failure creates normally', () {
    expect(
      () => Failure(''),
      returnsNormally,
    );
  });
}