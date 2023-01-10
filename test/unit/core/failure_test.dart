import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
  group('Failure', () {
    test('toString()', () {
      final desiredMessage = List.generate(
        3, 
        (index) => 'Failure: message$index',
      )
      .join('\n\tsubfailure: ');
      final failure = const Failure(
        message: '0', 
        failure:  Failure(
          message: '1',
          failure: Failure(
            message: '2',
          ),
        ),
      );
      print(failure.toString());
      expect(failure.toString(), desiredMessage);
    });

  });
}