import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
  final serializationData = {
    'type': {
      'object': DsDataType.bool,
      'serialization': '"type":"bool"',
    },
    'name': {
      'object': DsPointName('/path1/name1'),
      'serialization': '"name":"/path1/name1"',
    },
    'value': {
      'object': 0,
      'serialization': '"value":0',
    },
    'status': {
      'object': DsStatus.invalid,
      'serialization': '"status":10',
    },
    'cot': {
      'object': DsCot.inf,
      'serialization': '"cot":"Inf"',
    },
  };
  test('DsDataPoint toJson', () {
    final type = serializationData['type']!;
    final name = serializationData['name']!;
    final value = serializationData['value']!;
    final status = serializationData['status']!;
    final cot = serializationData['cot']!;
    final point = DsDataPoint(
      type: type['object'] as DsDataType,
      name: name['object'] as DsPointName,
      value: value['object'] as int,
      status: status['object'] as DsStatus,
      cot: cot['object'] as DsCot,
      timestamp: DsTimeStamp.now().toString(),
    );
    final serializedPoint = point.toJson();
    expect(serializedPoint.contains(type['serialization'] as String), true);
    expect(serializedPoint.contains(name['serialization'] as String), true);
    expect(serializedPoint.contains(value['serialization'] as String), true);
    expect(serializedPoint.contains(status['serialization'] as String), true);
    expect(serializedPoint.contains(cot['serialization'] as String), true);
  });
}