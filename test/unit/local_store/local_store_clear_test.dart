import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/local_store/local_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('LocalStore clear removes all entries from SharedPreferences', () async {
    // Adding prefixes to keys to not rewrite or read existing values 
    // in SharedPreferences (or values from another tests).
    const keyPrefix = 'test.local_store_clear.';
    final initialValues = {
      '${keyPrefix}test1': 'value1',
      '${keyPrefix}test2': 2,
      '${keyPrefix}test3': true,
    };
    SharedPreferences.setMockInitialValues(initialValues);
    final store = LocalStore();
    final result = await store.clear();
    expect(result, isTrue);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getKeys(), isEmpty);
  });
}