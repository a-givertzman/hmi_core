import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/local_store/local_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('LocalStore remove removes single entry from SharedPreferences', () async {
    // Adding prefixes to keys to not rewrite existing values 
    // in SharedPreferences (or values from another tests).
    const keyPrefix = 'test.local_store_remove.';
    const initialLocalStoreValues = {
      '${keyPrefix}test1': 'value1',
      '${keyPrefix}test2': 2,
      '${keyPrefix}test3': true,
    };
    SharedPreferences.setMockInitialValues(initialLocalStoreValues);
    final currentLocalStoreValues = Map.from(initialLocalStoreValues);
    final store = LocalStore();
    final preferences = await SharedPreferences.getInstance();
    final initialKeys = initialLocalStoreValues.keys;
    for (final key in initialKeys) {
      final result = await store.remove(key);
      expect(result, isTrue);
      currentLocalStoreValues.remove(key);
      for (final key in initialKeys) {
        expect(currentLocalStoreValues[key], preferences.get(key));
      }
    }
  });
}