import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/local_store/local_store.dart';

void main() {
  test('LocalStore decodeStr decodes string correctly', () async {
    const stringsEncodings = {
      '': '',
      'dmFsdWUx': 'value1',
      'NDQ0NCBzZGYgc2gzNA==': '4444 sdf sh34',
      'fmAhQCLihJYjJDslXjo/JiooKV8tKz1be31dfFwvLiwn': '~`!@"№#\$;%^:?&*()_-+=[{}]|\\/.,\'',
    };
    final store = LocalStore();
    for (final entry in stringsEncodings.entries) {
      expect(store.decodeStr(entry.key), equals(entry.value));
    }
  });
}