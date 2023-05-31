import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/local_store/local_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('LocalStore remove removes single entry from SharedPreferences', () async {
    const initialLocalStoreValues = {
      'test1': 'value1',
      'test2': 2,
      'test3': true,
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