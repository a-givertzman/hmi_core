import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/result/result.dart';
import 'package:hmi_core/src/core/text_file.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Log.initialize();
  const testAssetPath = 'assets/test/test.txt';
  const originalContent = 'test\nasset\ntext';
  group('TextFile.asset(...).read()', () {
    test('reads existing bundle file correctly', () async {
      const textFile = TextFile.asset(testAssetPath);
      final result = await textFile.content;
      expect(result, isA<Ok>());
      final receivedContent = (result as Ok<String, dynamic>).value;
      expect(receivedContent, equals(originalContent));
    });
    test('returns Err on unexisting bundle file', () async {
      const textFile = TextFile.asset('assets/unexisting_asset.txt');
      final result = await textFile.content;
      expect(result, isA<Err>());
    });
  });
}