import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/auth/user_login.dart';

void main() {
  group('UserLogin validate returns ValidationResult with message', () {
    final invalidLoginsWithMessages = {
      '': 'Some random message', 
      '1': 'Login is too short', 
      '1l': 'Something went wrong', 
      'x21': '', 
      't9rg': 'Error',
      List.filled(255, 'a').join(): 'Fail',
      List.filled(80, 'login').join(): 'Login is too long',
      List.filled(100, 'ld2').join(): 'Message 0',
      List.filled(85, 'base').join(): 'Unsatisfied input',
    };
    final validLogins = [
      'abcde', '12345', 'abc123',
      List.filled(254, 'a').join(),
      List.filled(254, '1').join(),
      List.filled(100, 'f3').join(),
    ];
    test('that was ginen on invalid login', () {
      for (final loginWithMessage in invalidLoginsWithMessages.entries) {
        final loginValue = loginWithMessage.key;
        final message = loginWithMessage.value;
        final login = UserLogin(value: loginValue);
        final result = login.validate(message: message);
        expect(result.message(), message);
      }
    });

    test('default on invalid login', () {
      const defaultMessage = 'Login must be..';
      for (final loginValue in invalidLoginsWithMessages.keys) {
        final login = UserLogin(value: loginValue);
        final result = login.validate();
        expect(result.message(), defaultMessage);
      }
    });

    test('as null on valid login', () {
      for(final loginValue in validLogins) {
        final login = UserLogin(value: loginValue);
        final valResult = login.validate();
        expect(valResult.message(), isNull);
      }
    });
  });
}