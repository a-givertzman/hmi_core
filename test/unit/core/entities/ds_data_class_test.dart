import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
  group('DsDataClass', () {
    test('fromString', () {
      expect(
        () => DsDataClass.fromString('invalidClass'),
        throwsA(isA<Failure>()),
      );
      for (final dataClass in DsDataClass.values) {
        expect(DsDataClass.fromString(dataClass.value), dataClass);
      }
    });
  });
}