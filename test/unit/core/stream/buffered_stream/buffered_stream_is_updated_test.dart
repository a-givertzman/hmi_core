import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/log/log_level.dart';
import 'package:hmi_core/src/core/stream/buffered_stream.dart';

void main() {
  Log.initialize(level: LogLevel.all);
  const streamValues = [1, 2, 3, 4, 5];
  test('BufferedStream isUpdated turns true after first received value', () async {
    final inputStreamController = StreamController<int>();
    final bufferedStream = BufferedStream(inputStreamController.stream);
    expect(bufferedStream.isUpdated, equals(false));
    for (final value in streamValues) {
      inputStreamController.add(value);
      await Future.delayed(const Duration(milliseconds: 1));
      expect(bufferedStream.isUpdated, equals(true));
    }
  });
}