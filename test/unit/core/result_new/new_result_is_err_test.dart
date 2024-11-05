import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_result_new.dart';
import 'test_data.dart';
///
/// Testing [Result].Err
void main() {
  group('Result is Err', () {
    test('Fails if [Result] instance isn`t [Err]', () {
      for(final value in testData) {
        final Result result = Err(value);
        expect(result is Err, equals(true));
        final Result target = Err(value);
        expect(result, equals(target));
      }
    });
  });
}