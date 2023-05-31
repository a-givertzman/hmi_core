import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/local_store/local_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('LocalStore clear removes all entries from SharedPreferences', () async {
    final initialValues = {
      'test1': 'value1',
      'test2': 2,
      'test3': true,
    };
    SharedPreferences.setMockInitialValues(initialValues);
    final store = LocalStore();
    final result = await store.clear();
    expect(result, isTrue);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getKeys(), isEmpty);
  });
}