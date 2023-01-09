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
    test('values', () {
      expect(DsDataClass.requestAll.value, 'requestAll');
      expect(DsDataClass.requestList.value, 'requestList');
      expect(DsDataClass.requestTime.value, 'requestTime');
      expect(DsDataClass.requestAlarms.value, 'requestAlarms');
      expect(DsDataClass.requestPath.value, 'requestPath');
      expect(DsDataClass.syncTime.value, 'syncTime');
      expect(DsDataClass.commonCmd.value, 'commonCmd');
      expect(DsDataClass.commonData.value, 'commonData');
    });
  });
}