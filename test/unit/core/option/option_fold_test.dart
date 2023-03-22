import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_option.dart';

void main() {
  group('Option fold', () {
    test('calls onSome function if it is instance of Some', () {
      for(int i=-50; i<=50; i++) {
        final Option<int> option = Some(i);
        final foldResult = option.fold(
          onSome: (v) => '$v',
          onNone: () => 'None',
        );
        expect(foldResult, equals('$i'));
      }
    });
    test('calls onNone function if it is instance of None', () {
      const Option<int> option = None();
      final foldResult = option.fold(
          onSome: (v) => '$v',
          onNone: () => 'None',
        );
      expect(foldResult, equals('None'));
    });
  });
}