import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/log/log_level.dart';
import 'package:hmi_core/src/core/stream/buffered_stream.dart';

void main() {
  Log.initialize(level: LogLevel.all);
  const streamValues = [351, 462, 9764534, 69754, 7089];
  group('BufferedStream stream', () {
    test('emits events with original order', () async {
      final inputStreamController = StreamController<int>();
      final bufferedStream = BufferedStream(inputStreamController.stream);
      int currentValue = -1;
      final subscription = bufferedStream.stream.listen((event) {
        currentValue = event;
      });
      for (final value in streamValues) {
        inputStreamController.add(value);
        await Future.delayed(const Duration(milliseconds: 0));
        expect(currentValue, equals(value));
      }
      await subscription.cancel();
    });
    test('buffers incoming events', () async {
      final inputStreamController = StreamController<int>();
      final bufferedStream = BufferedStream(inputStreamController.stream);
      for (final value in streamValues) {
        inputStreamController.add(value);
      }
      await Future.delayed(const Duration(milliseconds: 10));
      final receivedValues = await bufferedStream.stream.take(streamValues.length).toList();
      expect(receivedValues, streamValues);
    });
  });
  
}