import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/log/log_level.dart';
import 'package:hmi_core/src/core/stream/buffered_stream.dart';

void main() {
  Log.initialize(level: LogLevel.all);
  const initValue = 12345;
  const streamValues = [1, 2, 3, 4, 5];
  test('BufferedStream value at first equals initialValue and changes by each new from input stream', () async {
    final inputStreamController = StreamController<int>();
    final bufferedStream = BufferedStream(
      inputStreamController.stream, 
      initValue: initValue,
    );
    expect(bufferedStream.initialValue, equals(initValue));
    expect(bufferedStream.value, equals(initValue));
    for (final value in streamValues) {
      inputStreamController.add(value);
      await Future.delayed(const Duration(milliseconds: 1));
      expect(bufferedStream.value, equals(value));
    }
  });
}