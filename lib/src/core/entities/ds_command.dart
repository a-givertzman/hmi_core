import 'dart:convert';
import 'package:hmi_core/src/core/entities/ds_data_class.dart';
import 'package:hmi_core/src/core/entities/ds_data_type.dart';
import 'package:hmi_core/src/core/entities/ds_status.dart';
import 'package:hmi_core/src/core/entities/ds_timestamp.dart';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/log/log.dart';

///
/// Команда управления передаваемая в DataServer
class DsCommand<T> {
  final DsDataClass dsClass;
  final DsDataType type;
  final String path;
  final String name;
  final T value;
  final DsStatus status;
  final DsTimeStamp timestamp;
  ///
  const DsCommand({
    required this.dsClass,
    required this.type,
    required this.path,
    required this.name,
    required this.value,
    required this.status,
    required this.timestamp,
  });
  ///
  factory DsCommand.fromJson(String json) {
    // log(true, '[$DataPoint.fromJson] json: $json');
    try {
      final decoded = const JsonCodec().decode(json) as Map;
      return DsCommand(
        dsClass: DsDataClass.fromString('${decoded['class']}'),
        type: DsDataType.fromString('${decoded['type']}'),
        path: '${decoded['path']}',
        name: '${decoded['name']}',
        value: int.parse('${decoded['value']}') as T,
        status: DsStatus.fromString('${decoded['status']}'),
        timestamp: DsTimeStamp.parse('${decoded['timestamp']}'),
      );
    } catch (error) {
      log(true, '[$DsCommand.fromJson] error: $error\njson: $json');
      // log(ug, '[$DsCommand.fromJson] dataPoint: $dataPoint');
      throw Failure(
        message: 'Ошибка в методе $DsCommand.fromJson() $error',
        stackTrace: StackTrace.current,
      );
    }
    // print('event: $decoded');
  }
  ///
  String toJson() {
    return json.encode({
      'class': dsClass.value,
      'type': type.value,
      'path': path,
      'name': name,
      'value': value,
      'status': status.value,
      'timestamp': timestamp.toString(),
    });
  }
  ///
  String get valueStr => '$value';
  ///
  @override
  String toString() {
    return 'DsCommand {class: $dsClass, type: $type, name: $name, value: $value, status: $status, timestamp: $timestamp}';
  }
  ///
  @override
  int get hashCode => super.hashCode;
  ///
  @override
  bool operator ==(Object other) =>
    other is DsCommand &&
    other.runtimeType == runtimeType &&
    other.dsClass == dsClass &&
    other.type == type &&
    other.path == path &&
    other.name == name &&
    other.value == value &&
    other.status == status &&
    other.timestamp == timestamp;
}
