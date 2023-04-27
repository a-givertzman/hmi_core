import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/entities/stacked.dart';

void main() {
  group('Stacked pop', () {
    test('throws if used while empty', () {
      final stacked = Stacked();
      expect(()=>stacked.pop(), throwsRangeError);
    });
    test('removes last added element', () {
      final stacked = Stacked();
      final source = [1, 3, 5, 6 ,7];
      final target = [6, 5, 3, 1];
      for (final element in source) {
        stacked.push(element);
      }
      stacked.pop();
      expect(stacked.toList(), equals(target));
    });
  });
}