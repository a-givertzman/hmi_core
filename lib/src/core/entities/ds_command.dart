import 'package:hmi_core/src/core/entities/ds_data_class.dart';
import 'package:hmi_core/src/core/entities/ds_data_type.dart';
import 'package:hmi_core/src/core/entities/ds_status.dart';
import 'package:hmi_core/src/core/entities/ds_timestamp.dart';

///
/// Команда управления передаваемая в DataServer
class DsCommand<T> {
  final DsDataClass dsClass;
  final DsDataType type;
  final String name;
  final T value;
  final DsStatus status;
  final DsTimeStamp timestamp;
  ///
  const DsCommand({
    required this.dsClass,
    required this.type,
    required this.name,
    required this.value,
    required this.status,
    required this.timestamp,
  });
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
    other.name == name &&
    other.value == value &&
    other.status == status &&
    other.timestamp == timestamp;
}
