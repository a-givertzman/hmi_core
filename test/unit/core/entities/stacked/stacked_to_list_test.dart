import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/entities/stacked.dart';

void main() {
  group('Stacked to list', () {
    test('returns empty list if no elements', () {
      final stacked = Stacked();
      expect(stacked.toList(), isEmpty);
    });
    test('returns values in revesed order', () {
      final stacked = Stacked();
      final source = [1, 3, 8, 5, 13, 9, 20];
      final target = [20, 9, 13, 5, 8, 3, 1];
      for (final element in source) {
        stacked.push(element);
      }
      final receivedList = stacked.toList();
      for (int i = 0; i < receivedList.length; i++) {
        expect(receivedList[i], equals(target[i]));
      }
      expect(receivedList.length, equals(target.length));
    });
  });
}