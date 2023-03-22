import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_option.dart';

void main() {
  group('Option some factory', () {
    test('creates instance of Some', () {
      for(int i=-50; i<=50; i++) {
        final option = Option.some(i);
        expect(option, isA<Some<int>>());
      }
    });
  });
}