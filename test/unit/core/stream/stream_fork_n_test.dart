import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/stream/stream_fork.dart';

void main() {
  group('StreamFork[N]', () {
    test('Single', () async {
      final inputStreamController = StreamController();
      final fork = StreamForkSingle(
        inputStreamController.stream, 
      );
      expect(() => fork.stream(0), returnsNormally);
      expect(() => fork.stream(1), throwsA(isA<RangeError>()));
    });
    test('Double', () async {
      final inputStreamController = StreamController();
      final fork = StreamForkDouble(
        inputStreamController.stream, 
      );
      expect(() => fork.stream(0), returnsNormally);
      expect(() => fork.stream(1), returnsNormally);
      expect(() => fork.stream(2), throwsA(isA<RangeError>()));
    });
    test('Triple', () async {
      final inputStreamController = StreamController();
      final fork = StreamForkTriple(
        inputStreamController.stream, 
      );
      expect(() => fork.stream(0), returnsNormally);
      expect(() => fork.stream(1), returnsNormally);
      expect(() => fork.stream(2), returnsNormally);
      expect(() => fork.stream(3), throwsA(isA<RangeError>()));
    });
  });
}