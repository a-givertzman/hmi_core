import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
   group('DsCot', () {
    const correctStringsData = [
      {
        'string': 'Inf',
        'value': DsCot.inf,
      },
      {
        'string': 'Act',
        'value': DsCot.act,
      },
      {
        'string': 'ActCon',
        'value': DsCot.actCon,
      },
      {
        'string': 'ActErr',
        'value': DsCot.actErr,
      },
      {
        'string': 'Req',
        'value': DsCot.req,
      },
      {
        'string': 'ReqCon',
        'value': DsCot.reqCon,
      },
      {
        'string': 'ReqErr',
        'value': DsCot.reqErr,
      },
    ];
    test('.fromString(cot) deserializes correct strings properly', () async {
      for(final entry in correctStringsData) {
        final string = entry['string'] as String;
        final value = entry['value'] as DsCot;
        expect(DsCot.fromString(string), equals(value));
      }
    });
    test('.toString() serializes correctly', () async {
      for(final entry in correctStringsData) {
        final string = entry['string'] as String;
        final value = entry['value'] as DsCot;
        expect(value.toString(), equals(string));
      }
    });
    test('.fromString(cot) throws on incorrect strings', () async {
      const incorrectStrings = ['asd', 'sdg',  '', 'dfghhfd', '34j5ls', 'a', 'i', 'r'];
      for(final string in incorrectStrings) {
        expect(() => DsCot.fromString(string), throwsA(isA<ArgumentError>()));
      }
    });
  });
}