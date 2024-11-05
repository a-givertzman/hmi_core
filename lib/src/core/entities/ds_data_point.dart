import 'dart:convert';
import 'package:hmi_core/src/core/entities/ds_cot.dart';
import 'package:hmi_core/src/core/entities/ds_data_type.dart';
import 'package:hmi_core/src/core/entities/ds_point_name.dart';
import 'package:hmi_core/src/core/entities/ds_status.dart';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/result/result.dart';

///
abstract class IDataPoint<T> {}

///
class DsDataPoint<T> implements IDataPoint {
  final DsDataType type;
  final DsPointName name;
  final T value;
  final DsStatus status;
  final int history;
  final int alarm;
  final DsCot cot;
  final String timestamp;
  ///
  /// Represent a data received from SocketDataServer
  /// wich contains map in json like:
  ///   type: S7DataType
  ///   name: 'part.subpart1.sabpart...'
  ///   value: current value of type depending on S7DataType
  const DsDataPoint({
    required this.type,
    required this.name,
    required this.value,
    this.history = 0,
    this.alarm = 0,
    required this.status,
    required this.timestamp,
    required this.cot,
  });
  ///
  String toJson() {
    return json.encode({
      'type': type.value,
      'name': name.toString(),
      'value': value,
      'status': status.value,
      'history': history,
      'alarm': alarm,
      'cot': cot.toString(),
      'timestamp': timestamp,
    });
  }
  //
  @override
  String toString() {
    return 'DataPoint {type: $type, name: $name, value: $value, status: $status, cot: $cot, history: $history, alarm: $alarm}';
  }
  //
  @override
  bool operator ==(Object other) =>
    other is DsDataPoint
    && type == other.type
    && name == other.name
    && value == other.value
    && status == other.status
    && history == other.history
    && alarm == other.alarm
    && cot == other.cot
    && timestamp == other.timestamp;
  //
  @override
  int get hashCode => type.hashCode ^ name.hashCode ^ value.hashCode ^ status.hashCode ^ history.hashCode ^ alarm.hashCode ^ timestamp.hashCode ^ cot.hashCode;
  ///
  ResultF<DsDataPoint<T>> toResult() => switch(cot) {
    DsCot.act    ||
    DsCot.req    ||
    DsCot.inf    ||
    DsCot.reqCon ||
    DsCot.actCon => Ok(this),
    DsCot.reqErr || DsCot.actErr => Err(
      Failure(
        message: value, 
        stackTrace: 
        StackTrace.current,
      ),
    )
  };
}