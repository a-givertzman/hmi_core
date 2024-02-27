import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/text_file.dart';

void main() {
  const testFilePath = 'test.txt';
  const originalContent = 'first line some test text 12345\nsecond line some test text 12345';
  late final File testFile;
  setUpAll(() {
    testFile = File(testFilePath)..writeAsString(originalContent, flush: true);
  });
  tearDownAll(() {
    testFile.delete();
  });
  test('TextFile path reads local file correctly', () async {
    const textFile = TextFile.path(testFilePath);
    final receivedContent = await textFile.content;
    expect(originalContent, equals(receivedContent));
  });
}