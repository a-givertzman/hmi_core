import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/result/result.dart';
import 'package:hmi_core/src/core/text_file.dart';

void main() {
  Log.initialize();
  const testFileNamePrefix = 'text_file_path_write_test';
  const contentToWrite = [
    'first line some test text 12345\nsecond line some test text 12345\n',
    '',
    '0123456789',
    'abcdefghijklmnopqrstuvwxyz',
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    'абвгдеёжзийклмнопрстуфхцчшщъыьэюя',
    'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ',
    '!@#\$%^&*()_+=-"№;:?./\\|[]{}',
  ];
  group('TextFile.asset(...).read()', () {
    setUpAll(() async {
      await Future.wait([
        for(int i=0; i < contentToWrite.length; i++) 
          File('$testFileNamePrefix-$i.txt').writeAsString(contentToWrite[i]),
      ]);
    });
    tearDownAll(() async {
      await Future.wait([
        for(int i=0; i < contentToWrite.length; i++) 
          File('$testFileNamePrefix-$i.txt').delete(),
      ]);
    });
    test('reads local file correctly', () async {
      for(int i=0; i < contentToWrite.length; i++) {
        final fileName = '$testFileNamePrefix-$i.txt';
        final textFile = TextFile.path(fileName);
        final result = await textFile.content;
        expect(result, isA<Ok>());
        final receivedContent = (result as Ok<String, dynamic>).value;
        expect(receivedContent, equals(contentToWrite[i]));
      }
    });
    test('returns Err on unexisting file', () async {
      const textFile = TextFile.path('unexisting_asset_file.txt');
      final result = await textFile.content;
      expect(result, isA<Err>());
    });
  });
}