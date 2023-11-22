import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_option.dart';
import 'test_data.dart';

void main() {
  group('Option Some constructor', () {
    test('creates instance of Some', () {
      for(int i=-50; i<=50; i++) {
        expect(Some(i), isA<Some<int>>());
        expect(Some(i / 2.0), isA<Some<double>>());
        expect(Some(i % 2 == 0), isA<Some<bool>>());
        expect(Some('$i'), isA<Some<String>>());
        expect(Some(ForTestOptionOnly('$i')), isA<Some<ForTestOptionOnly>>());
      }
      const userClassOption = Some(ForTestOptionOnly(''));
      expect(userClassOption, isA<Some<ForTestOptionOnly>>());
    });
  });
}