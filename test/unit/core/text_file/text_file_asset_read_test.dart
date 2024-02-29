import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/text_file.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const testAssetPath = 'assets/test/test.txt';
  const originalContent = 'test\nasset\ntext';
  group('TextFile.asset(...).read()', () {
    test('reads existing bundle file correctly', () async {
      const textFile = TextFile.asset(testAssetPath);
      final receivedContent = await textFile.content;
      expect(originalContent, equals(receivedContent));
    });
    test('throws error on unexisting bundle file', () async {
      const textFile = TextFile.asset('assets/unexisting_asset.txt');
      expect(() async => await textFile.content, throwsA(isA<Error>()));
    });
  });
}