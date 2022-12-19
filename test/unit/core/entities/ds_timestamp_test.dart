import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
  group('DsTimeStamp', () {
    test('parse', () {
      final datetime = DateTime.now();
      expect(() => DsTimeStamp.parse('0test'), throwsA(isA<Failure>()));
      expect(DsTimeStamp.parse(datetime.toString()).value, datetime);
    });
    test('toString', () {
      final datetime = DateTime.now();
      final dsTimeStamp = DsTimeStamp(dateTime: datetime);
      expect(dsTimeStamp.toString(), datetime.toIso8601String());
    });
    test('operator ==', () {
      final datetime = DateTime.now();
      final timestamp = DsTimeStamp(dateTime: datetime);
      
      expect(timestamp == 'test', false);
      expect(timestamp == DsTimeStamp(dateTime: datetime), true);
      expect(timestamp == DsTimeStamp(dateTime: DateTime.now()), false);
    });
  });
}