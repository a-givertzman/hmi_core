import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/entities/stacked.dart';

void main() {
  
  group('Stacked push', () { 
    test('adds elements endlessly if length is not specified', () {
      const initialLength = 0;
      const targetLength = 100;
      final stacked = Stacked();
      expect(stacked.toList().length, initialLength);
      for (int i=0; i<targetLength; i++) {
        stacked.push(i);
      }
      expect(stacked.toList().length, targetLength);
    });
    test('adds elements while target length is not achieved, then removes the oldest', () {
      const initialLength = 0;
      const specifiedLength = 30;
      const targetLength = 100;
      final stacked = Stacked(length: specifiedLength);
      expect(stacked.toList().length, initialLength);
      for (int i=0; i<targetLength; i++) {
        stacked.push(i);
      }
      expect(stacked.toList().length, specifiedLength);
    });
    test('adds elements to the beginning', () {
      const targetLength = 100;
      final stacked = Stacked();
      for (int i=0; i<targetLength; i++) {
        stacked.push(i);
        expect(stacked.peek, equals(i));
      }
    });
  });
}