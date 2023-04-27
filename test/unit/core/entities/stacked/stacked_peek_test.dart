import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/entities/stacked.dart';

void main() {
  group('Stacked peek', () {
    test('throws if used while empty', () {
      final stacked = Stacked();
      expect(()=>stacked.peek, throwsStateError);
    });
    test('always points to the first element', () {
      const targetLength = 100;
      final stacked = Stacked();
      for (int i=0; i<targetLength; i++) {
        stacked.push(i);
        expect(stacked.peek, equals(i));
      }
    });
  });
}