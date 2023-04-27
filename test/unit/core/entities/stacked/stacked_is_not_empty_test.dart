import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/entities/stacked.dart';

void main() {
  group('Stacked is not empty', () {
    test('returns false if there are no elements', () {
      final stacked = Stacked();
      expect(stacked.isNotEmpty, isFalse);
    });
    test('returns true if there are some elements', () {
      final stacked = Stacked();
      expect(stacked.isNotEmpty, isFalse);
      for(int i = 0; i<20; i++) {
        stacked.push(i);
        expect(stacked.isNotEmpty, isTrue);
      }
    }); 
    test('returns false then filled and emptied after it', () {
      final stacked = Stacked();
      const targetLength = 20;
      expect(stacked.isNotEmpty, isFalse);
      for(int i = 0; i<targetLength; i++) {
        stacked.push(i);
      }
      for(int i = 0; i<targetLength; i++) {
        stacked.pop();
      }
      expect(stacked.isNotEmpty, isFalse);
    }); 
  });
}