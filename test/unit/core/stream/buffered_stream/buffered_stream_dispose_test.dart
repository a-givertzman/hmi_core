import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/log/log_level.dart';
import 'package:hmi_core/src/core/stream/buffered_stream.dart';

void main() {
  Log.initialize(level: LogLevel.all);
  const streamValues = [1, 2, 3, 4, 5];
  test('BufferedStream dispose cancels input subscription and allows read from buffer', () async {
    final inputStreamController = StreamController<int>();
    final bufferedStream = BufferedStream(inputStreamController.stream);
    for (final value in streamValues) {
      inputStreamController.add(value);
    }
    await Future.delayed(const Duration(milliseconds: 10));
    await bufferedStream.dispose();
    expect(inputStreamController.hasListener, equals(false));
    final receivedValues = await bufferedStream.stream.take(streamValues.length).toList();
    expect(receivedValues, streamValues);
  });
}