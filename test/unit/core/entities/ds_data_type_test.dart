import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
  group('DsDataType', () {
    test('fromString', () {
      expect(
        () => DsDataType.fromString('invalidType'),
        throwsA(isA<Failure>()),
      );
      for (final dataType in DsDataType.values) {
        expect(DsDataType.fromString(dataType.value), dataType);
        expect(DsDataType.fromString(dataType.value.toUpperCase()), dataType);
      }
    });
    test('values', () {
        expect(DsDataType.bool.value, 'bool');
        expect(DsDataType.bool.length, 1);
        //
        expect(DsDataType.integer.value, 'int');
        expect(DsDataType.integer.length, 2);
        //
        expect(DsDataType.uInt.value, 'uint');
        expect(DsDataType.uInt.length, 2);
        //
        expect(DsDataType.dInt.value, 'dint');
        expect(DsDataType.dInt.length, 4);
        //
        expect(DsDataType.word.value, 'word');
        expect(DsDataType.word.length, 2);
        //
        expect(DsDataType.lInt.value, 'lint');
        expect(DsDataType.lInt.length, 8);
        //
        expect(DsDataType.real.value, 'real');
        expect(DsDataType.real.length, 4);
        //
        expect(DsDataType.time.value, 'time');
        expect(DsDataType.time.length, 4);
        //
        expect(DsDataType.dateAndTime.value, 'date_and_time');
        expect(DsDataType.dateAndTime.length, 8);
    });
  });
}