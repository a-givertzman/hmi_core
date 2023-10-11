import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_option.dart';

void main() {
  group('Option None constructor', () {
    test('creates instance of None', () {
      const Option<int> option = None();
      expect(option, isA<None>());
    });
    test('creates instance of Option of any type', () {
      const none = None();
      expect(none, isA<Option<int>>());
      expect(none, isA<Option<bool>>());
      expect(none, isA<Option<double>>());
      expect(none, isA<Option<String>>());
    });
  });
}