import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_option.dart';

void main() {
  group('Option none factory', () {
    test('creates instance of None', () {
      const option = Option<int>.none();
      expect(option, isA<None<int>>());
    });
  });
}