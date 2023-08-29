import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/local_store/local_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('LocalStore write string persists entry in SharedPreferences', () async {
    SharedPreferences.setMockInitialValues({});
    // Adding prefixes to keys to not rewrite or read existing values 
    // in SharedPreferences (or values from another tests).
    const keyPrefix = 'test.local_store_write_string.';
    const writePairs = {
      '${keyPrefix}test1': 'value1',
      '${keyPrefix}test2': '2',
      '${keyPrefix}test3': 'true',
    };
    final store = LocalStore();
    final preferences = await SharedPreferences.getInstance();
    for (final writePair in writePairs.entries) {
      expect(preferences.get(writePair.key), isNull);
      final result = await store.writeString(writePair.key, writePair.value);
      expect(result, isTrue);
      expect(preferences.get(writePair.key), writePair.value);
    }
  });
}