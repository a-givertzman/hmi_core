import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/text_file.dart';

void main() {
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
  setUpAll(() async {
    await Future.wait([
      for(int i=0; i < contentToWrite.length; i++) 
        File('$testFileNamePrefix-$i.txt').create(),
    ]);
  });
  tearDownAll(() async {
    await Future.wait([
      for(int i=0; i < contentToWrite.length; i++) 
        File('$testFileNamePrefix-$i.txt').delete(),
    ]);
  });
  test('TextFile.path(...).write() writes local file correctly', () async {
    for(int i=0; i < contentToWrite.length; i++) {
      final testFilePath = '$testFileNamePrefix-$i.txt';
      final textFile = TextFile.path(testFilePath);
      await textFile.write(contentToWrite[i]);
      expect(await File(testFilePath).readAsString(), equals(contentToWrite[i]));
    }
  });
}