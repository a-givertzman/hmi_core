import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';
import 'package:hmi_core/src/core/entities/ds_point_name.dart';

void main() {
  final fullPath = 'path1/name1';
  final serializationData = {
    'type': {
      'object': DsDataType.bool,
      'serialization': '"type":"bool"',
    },
    'name': {
      'object': DsPointName(fullPath: fullPath),
      'serialization': '"name":"$fullPath"',
    },
    'value': {
      'object': 0,
      'serialization': '"value":0',
    },
    'status': {
      'object': DsStatus.invalid,
      'serialization': '"status":10',
    },
  };
  test('DsDataPoint toJson', () {
    final type = serializationData['type']!;
    final name = serializationData['name']!;
    final value = serializationData['value']!;
    final status = serializationData['status']!;
    final point = DsDataPoint(
      type: type['object'] as DsDataType,
      name: name['object'] as DsPointName,
      value: value['object'] as int,
      status: status['object'] as DsStatus,
      timestamp: DsTimeStamp.now().toString(),
    );
    final serializedPoint = point.toJson();
    expect(serializedPoint.contains(type['serialization'] as String), true);
    expect(serializedPoint.contains(name['serialization'] as String), true);
    expect(serializedPoint.contains(value['serialization'] as String), true);
    expect(serializedPoint.contains(status['serialization'] as String), true);
  });
}