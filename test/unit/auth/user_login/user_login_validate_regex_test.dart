import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/auth/user_login.dart';

void main() {
  group('UserLogin validate returns ValidationResult with valid field as', () {
    final lengthInvalidLogins = [
      '', '1', '1l', 'x21', 't9rg',
      List.filled(255, 'a').join(),
      List.filled(80, 'login').join(),
      List.filled(100, 'ld2').join(),
      List.filled(85, 'base').join(),

    ];
    final lengthValidLogins = [
      'abcde', '12345', 'abc123',
      List.filled(254, 'a').join(),
      List.filled(254, '1').join(),
      List.filled(100, 'f3').join(),
    ];
    test('false on too short or too long login', () {
      for(final loginValue in lengthInvalidLogins) {
        final login = UserLogin(value: loginValue);
        final valResult = login.validate();
        expect(valResult.valid(), isFalse);
      }
    });
    test('true on login with valid length', () {
      for(final loginValue in lengthValidLogins) {
        final login = UserLogin(value: loginValue);
        final valResult = login.validate();
        expect(valResult.valid(), isTrue);
      }
    });
    ///
    final invalidSymbols = ' =+)(*&?^:%;\$#№"@!~`,\\'.split('');
    // Making values with valid prefix and 
    // one invalid symbol that should fail the test
    final invalidSymbolLogins = [
      for(final symbol in invalidSymbols)
        'prefix$symbol',
    ];
    final validSymbols = '.-_0123456789abcdefghijklmnopqrstuvwxyz'.split('');
    // Making values with valid prefix and 
    // one valid symbol that should pass the test
    final validSymbolLogins = [
      for(final symbol in validSymbols)
        'prefix$symbol',
    ];
    test('false on login with invalid symbols', () {
      for(final loginValue in invalidSymbolLogins) {
        final login = UserLogin(value: loginValue);
        final valResult = login.validate();
        expect(valResult.valid(), isFalse);
      }
    });
    test('true on login with valid length', () {
      for(final loginValue in validSymbolLogins) {
        final login = UserLogin(value: loginValue);
        final valResult = login.validate();
        expect(valResult.valid(), isTrue);
      }
    });
  });
}