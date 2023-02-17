import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
  group('ValueString', () {
    final dict = [
      'test test test',
      'Тест Тест Тест',
      '123',
      '!@#%^&*()_+',
    ];
    test('create', () {
      expect(const ValueString('10'), isInstanceOf<ValueObject<String>>());
    });
    test('toDomain()', () {
      const stringValueObject = ValueString('test test test');
      final stringValueObject1 = const ValueString('').toDomain('test test test');
      expect(stringValueObject, equals(stringValueObject1));
      for (final text in dict) {
        final stringValueObject = ValueString(text);
        final stringValueObject1 = const ValueString('').toDomain(text);
        expect(stringValueObject, equals(stringValueObject1));
      }
    });
    test('operator ==()', () {
      for (final text in dict) {
        final stringValueObject = ValueString(text);
        final stringValueObject1 = const ValueString('').toDomain(text);
        expect(stringValueObject == stringValueObject1, equals(true));
      }
      for (final text in dict) {
        final stringValueObject = ValueString(text);
        final stringValueObject1 = const ValueString('').toDomain('$text .');
        expect(stringValueObject == stringValueObject1, equals(false));
      }
    });
    test('value', () {
      for (final text in dict) {
        final stringValueObject = ValueString(text);
        expect(stringValueObject.value, equals(text));
      }
    });
  });
}
