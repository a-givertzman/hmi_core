import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/entities/stacked.dart';

void main() {
  group('Stacked clear', () {
    test('completes normally if there are no elements', () {
      final stacked = Stacked();
      expect(()=>stacked.clear(), returnsNormally);
    });
  });
  test('removes all elements', () {
    const targetLength = 100;
      final stacked = Stacked();
      for (int i = 0; i < targetLength; i++) {
        stacked.push(i);
      }
      expect(stacked.isEmpty, isFalse);
      expect(stacked.isNotEmpty, isTrue);
      stacked.clear();
      expect(stacked.isEmpty, isTrue);
      expect(stacked.isNotEmpty, isFalse);
      expect(stacked.toList(), isEmpty);
  });
}