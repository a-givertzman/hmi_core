import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/local_store/local_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('LocalStore write string encoded', () {
    // Adding prefixes to keys to not rewrite or read existing values 
    // in SharedPreferences (or values from another tests).
    const keyPrefix = 'test.local_store_write_decoded_string.';
    const initialPairs = {
      '${keyPrefix}test1': { 
        'decoded': 'value1',
        'encoded': 'dmFsdWUx',
      },
      '${keyPrefix}key2': { 
        'decoded': '',
        'encoded': '',
      },
      '${keyPrefix}3key': { 
        'decoded': '4444 sdf sh34',
        'encoded': 'NDQ0NCBzZGYgc2gzNA==',
      },
      '${keyPrefix}4test':  { 
        'decoded': '~`!@"№#\$;%^:?&*()_-+=[{}]|\\/.,\'',
        'encoded': 'fmAhQCLihJYjJDslXjo/JiooKV8tKz1be31dfFwvLiwn',
      },
    };
    final decodedPairs = initialPairs.map(
      (key, value) => MapEntry(key, value['decoded']!),
    );
    final encodedPairs = initialPairs.map(
      (key, value) => MapEntry(key, value['encoded']!),
    );
    test('persists entry in SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final store = LocalStore();
      final preferences = await SharedPreferences.getInstance();
      for (final writePair in decodedPairs.entries) {
        expect(preferences.get(writePair.key), isNull);
        final result = await store.writeStringEncoded(writePair.key, writePair.value);
        expect(result, isTrue);
        expect(preferences.get(writePair.key), encodedPairs[writePair.key]);
      }
    });
    test('persists empty string value as is (without encryption)', () async {
      SharedPreferences.setMockInitialValues({});
      final store = LocalStore();
      final preferences = await SharedPreferences.getInstance();
      for (final writeKey in initialPairs.keys) {
        expect(preferences.get(writeKey), isNull);
        final result = await store.writeStringEncoded(writeKey, '');
        expect(result, isTrue);
        expect(preferences.get(writeKey), '');
      }
    });
  });
}