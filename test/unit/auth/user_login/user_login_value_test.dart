import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/auth/user_login.dart';

void main() {
  test('UserLogin value returns value provided to constructor', () {
    final values = [
      '', ' ', ';', '=-+_)(*&?^:%;\$#№"@!~`\\', 
      '1234567890', 'login', 'user123',
    ];
    for(final value in values) {
      final login = UserLogin(value: value);
      expect(login.value(), equals(value));
    }
  });
}
