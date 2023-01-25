import 'package:hmi_core/src/core/error/failure.dart';

enum DsDataType {
  /// Possible values: 
  ///   - Siemens S7 controllers: 0 or 1
  bool('bool', 1),
  /// Possible values:
  ///   - Siemens S7 controllers: integers from -32768 to 32767
  integer('int', 2),
  /// Possible values:
  ///   - Siemens S7 controllers: integers from 0 to 65535
  uInt('uint', 2),
  /// Possible values:
  ///   - Siemens S7 controllers: integers from -2147483648 to 2147483647
  dInt('dint', 4),
  /// Possible values:
  ///   - Siemens S7 controllers: integers from 0 to 65535
  word('word', 2),
  /// Possible values:
  ///   - Siemens S7 controllers: integers from -9223372036854775808 to 9223372036854775807
  lInt('lint', 8),
  /// Possible values:
  ///   - Siemens S7 controllers: 
  ///     - int from 3.402823e+38 to -3.402823e+38
  ///     - real from -1.175495e-38 to 1.175495e-38
  real('real', 4),
  /// Possible values:
  time('time', 4),
  dateAndTime('date_and_time', 8);
  ///
  const DsDataType(this.value, this.length);
  final String value;
  final int length;
  static final _valueMapping = <String, DsDataType>{
    for (var dataType in DsDataType.values) 
      dataType.value : dataType,
  };
  ///
  factory DsDataType.fromString(String value) {
    final lvalue = value.toLowerCase();
    final dataType = _valueMapping[lvalue];
    if (dataType == null) {
      throw Failure.connection(
        message: 'Ошибка в методе $DsDataType._extract: неизвестный тип данных $value',
        stackTrace: StackTrace.current,
      );
    }
    return dataType;
  }
  ///
  @override
  String toString() {
    return 'DsDataType {name: $name, length: $length}';
  }
}
final b = DsDataType.bool;
final c = DsDataType.integer;
final c1 = DsDataType.uInt;
final c2 = DsDataType.dInt;
final c3 = DsDataType.word;
final c4 = DsDataType.lInt;
final c5 = DsDataType.real;