import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/stream/stream_fork.dart';

void main() {
  group('StreamFork', () {
    const inputStreamData = [123, 321, 456, 987, 42];
    test('buffering all incoming events before any subscription occurs', () async {
      const listenersCount = 5;
      final inputStreamController = StreamController<int>();
      final fork = StreamFork(
        inputStreamController.stream, 
        listenersCount: listenersCount,
      );
      for (final item in inputStreamData) {
        inputStreamController.add(item);
      }
      for (int i = 0; i < listenersCount; i++) {
        final outputStreamData = await fork.stream(i).take(inputStreamData.length).toList();
        expect(outputStreamData, inputStreamData);
      }
    });
    test('cancels input stream subscription after all output subscriptions were canceled', () async {
      const listenersCount = 10;
      final inputStreamController = StreamController();
      final fork = StreamFork(
        inputStreamController.stream, 
        listenersCount: listenersCount,
      );
      for (final item in inputStreamData) {
        inputStreamController.add(item);
      }
      for (int i = 0; i < listenersCount; i++) {
        await fork.stream(i).listen(null).cancel();
      }
      expect(inputStreamController.hasListener, false);
    });
    test('propagates closing from input to output streams', () async {
      const listenersCount = 10;
      final inputStreamController = StreamController();
      final fork = StreamFork(
        inputStreamController.stream, 
        listenersCount: listenersCount,
      );
      for (final item in inputStreamData) {
        inputStreamController.add(item);
      }
      inputStreamController.close();
      for (int i = 0; i < listenersCount; i++) {
        expect(() => fork.stream(i).single, throwsA(isStateError));
      }
    });
  });
}