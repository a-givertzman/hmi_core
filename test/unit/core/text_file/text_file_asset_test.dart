import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/text_file.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const testAssetPath = 'assets/test/test.txt';
  const originalContent = 'test\nasset\ntext';
  test('TextFile asset reads bundle file correctly', () async {
    const textFile = TextFile.asset(testAssetPath);
    final receivedContent = await textFile.content;
    expect(originalContent, equals(receivedContent));
  });
}