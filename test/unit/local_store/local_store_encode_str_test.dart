import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/local_store/local_store.dart';

void main() {
  test('LocalStore encodeStr encodes string correctly', () async {
    const stringsEncodings = {
      'value1': 'dmFsdWUx',
      '4444 sdf sh34': 'NDQ0NCBzZGYgc2gzNA==',
      '~`!@"№#\$;%^:?&*()_-+=[{}]|\\/.,\'': 'fmAhQCLihJYjJDslXjo/JiooKV8tKz1be31dfFwvLiwn',
    };
    final store = LocalStore();
    for (final entry in stringsEncodings.entries) {
      expect(store.encodeStr(entry.key), equals(entry.value));
    }
  });
}