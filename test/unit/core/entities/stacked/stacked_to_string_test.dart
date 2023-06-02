import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/entities/stacked.dart';

void main() {
  group('Stacked to string', () {
    test('return string with reversed representation', () {
      final data = {
        '[1, 2, 3, 4, 5]': [5, 4, 3, 2, 1],
        '[1]': [1],
        '[25, 345, 2364, 856, 34]': [34, 856, 2364, 345, 25],
      };
      for (final entry in data.entries) {
        final stacked = Stacked();
        for (final element in entry.value) {
          stacked.push(element);
        }
        expect(stacked.toString(), equals(entry.key));
      }
    });
  });
}