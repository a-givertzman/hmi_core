import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';


void main() {
  group('UserPassword', () {
    Log.initialize(level: LogLevel.all);
    const log = Log('UserPassword');
    AppSettings.initialize(
      jsonMap: JsonMap.fromString('{"passwordKey": "1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNMЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЁЯЧСМИТЬБЮйцукенгшщзхъфывапролджэёячсмитьбю"}'),
    );
    test('value', () async {
      const rawPassValue = '123qwe';
      final pass = UserPassword(value: rawPassValue);
      log.debug('pass: ${pass.value()}');
      expect(rawPassValue == pass.value(), true, reason: 'password must be equals to it value');
    });
    test('encrypted', () async {
      const rawPassValue = '123qwe';
      final pass = UserPassword(value: rawPassValue);
      log.debug('pass: ${pass.value()}');
      final passEncrypted = pass.encrypted();
      log.debug('passEncrypted: $passEncrypted');
      expect(rawPassValue != passEncrypted, true, reason: 'password must not be equals to it encrypted value');
    });
    test('decrypted', () async {
      const rawPassValue = '123qwe';
      final pass = UserPassword(value: rawPassValue);
      log.debug('pass: ${pass.value()}');
      final passEncrypted = pass.encrypted();
      log.debug('passEncrypted: $passEncrypted');
      final pass1 = UserPassword(value: passEncrypted);
      final passDecrypted = pass1.decrypted();
      log.debug('passDecrypted: $passDecrypted');
      expect(rawPassValue, passDecrypted, reason: 'password mast be equal to it decripted value');
    });
    test('validate', () async {
      final pass = UserPassword(value: '');
      expect(pass.validate().valid(), ValidationResult(valid: false, message: null).valid(), reason: 'password of length less then ${pass.minLength} character(s) by default mast be invalid');
      final pass1 = UserPassword(value: '1');
      expect(pass1.validate().valid(), ValidationResult(valid: true, message: null).valid(), reason: 'password of length ${pass.minLength}...${pass.maxLength} characters by default mast be valid');
      final pass30 = UserPassword(value: '012345678901234567890123456789');
      expect(pass30.validate().valid(), ValidationResult(valid: true, message: null).valid(), reason: 'password of length ${pass.minLength}...${pass.maxLength} characters by default mast be valid');
      final pass31 = UserPassword(value: '0123456789012345678901234567890');
      expect(pass31.validate().valid(), ValidationResult(valid: false, message: null).valid(), reason: 'password of length more then ${pass.maxLength} character(s) by default mast be invalid');
    });
  });
}