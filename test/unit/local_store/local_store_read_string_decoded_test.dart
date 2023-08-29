import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/local_store/local_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('LocalStore read string decoded', () {
    // Adding prefixes to keys to not rewrite or read existing values 
    // in SharedPreferences (or values from another tests).
    const keyPrefix = 'test.local_store_read_string_decoded.';
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
    test('returns decoded value if key exist in SharedPreferences', () async {
      SharedPreferences.setMockInitialValues(encodedPairs);
      final store = LocalStore();
      final preferences = await SharedPreferences.getInstance();
      for (final entry in decodedPairs.entries) {
        final receivedValue = await store.readStringDecoded(entry.key);
        expect(receivedValue, entry.value);
        expect(preferences.get(entry.key), encodedPairs[entry.key]);
      }
    });
    test('returns empty string if key does not exist in SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final readKeys = initialPairs.keys; 
      final store = LocalStore();
      final preferences = await SharedPreferences.getInstance();
      for (final key in readKeys) {
        expect(preferences.get(key), null);
        final receivedValue = await store.readStringDecoded(key);
        expect(receivedValue, '');
      }
    });
  });
}