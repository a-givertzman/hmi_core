import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_option.dart';

void main() {
  group('Option Some constructor', () {
    test('creates instance of Some', () {
      for(int i=-50; i<=50; i++) {
        final option = Some(i);
        expect(option, isA<Some<int>>());
      }
      for(int i=-50; i<=50; i++) {
        final option = Some(i % 2 == 0);
        expect(option, isA<Some<bool>>());
      }
      for(int i=-50; i<=50; i++) {
        final option = Some('$i');
        expect(option, isA<Some<String>>());
      }
    });
  });
}