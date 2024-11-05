import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_result_new.dart';
import 'test_data.dart';
///
/// Testing [Result].Ok
void main() {
  group('Result is Ok', () {
    test('Fails if [Result] instance isn`t [Ok]', () {
      for(final value in testData) {
        final Result result = Ok(value);
        expect(result is Ok, equals(true));
        final Result target = Ok(value);
        expect(result, equals(target));
      }
    });
  });
}