import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/local_store/local_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('LocalStore read string', () {
    // Adding prefixes to keys to not rewrite or read existing values 
    // in SharedPreferences (or values from another tests).
    const keyPrefix = 'test.local_store_read_string.';
    const initialPairs = {
      '${keyPrefix}test1': 'value1',
      '${keyPrefix}key2': '2',
      '${keyPrefix}3': 'true',
      '${keyPrefix}4key': '4444',
      '${keyPrefix}5test': '54321',
    };
    test('returns value if key exist in SharedPreferences', () async {
      SharedPreferences.setMockInitialValues(initialPairs);
      final store = LocalStore();
      final preferences = await SharedPreferences.getInstance();
      for (final entry in initialPairs.entries) {
        final receivedValue = await store.readString(entry.key);
        expect(receivedValue, entry.value);
        expect(preferences.get(entry.key), entry.value);
      }
    });
    test('returns empty string if key does not exist in SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final readKeys = initialPairs.keys; 
      final store = LocalStore();
      final preferences = await SharedPreferences.getInstance();
      for (final key in readKeys) {
        expect(preferences.get(key), null);
        final receivedValue = await store.readString(key);
        expect(receivedValue, '');
      }
    });
  });
}