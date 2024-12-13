import 'app_settings.dart';
import 'package:hmi_core/src/core/error/failure.dart';

///
/// Holds setting value stored in AppSettings by it name
/// - value can be returned in int, double or string represantation 
class Setting {
  final String _name;
  final double _factor;
  final dynamic Function(Failure err)? _onError;
  ///
  /// - [name] - the name of value stored in AppSettings
  /// - [factor] - returned value int or double will by multiplied by factor
  const Setting(
    String name, {
    double factor = 1.0,
    dynamic Function(Failure err)? onError,
  }) : 
    _name = name,
    _factor = factor,
    _onError = onError;
  ///
  /// Returns [Setting] new instance containing a [value]
  const factory Setting.from(dynamic value) = _SettingValue;
  /// 
  /// Returns setting value in int represantation
  int get toInt {
    final value = AppSettings.getSetting(_name, _onError);
    if (value is int) {
      return _factor == 1 ? value : (value * _factor).toInt();
    }
    return (double.parse('$value') * _factor).toInt();
  }
  /// 
  /// Returns setting value in double represantation
  double get toDouble {
    final value = AppSettings.getSetting(_name, _onError);
    if (value is double) {
      return value * _factor;
    }
    return double.parse('$value') * _factor;
  }
  /// 
  /// Returns setting value in string represantation
  @override
  String toString() => '${AppSettings.getSetting(_name, _onError)}';
}
///
///
class _SettingValue implements Setting {
  final dynamic _value;
  //
  const _SettingValue(dynamic value) : _value = value;
  //
  @override
  double get _factor => throw UnimplementedError();
  //
  @override
  String get _name => throw UnimplementedError();
  //
  @override
  dynamic Function(Failure err)? get _onError => throw UnimplementedError();
  //
  @override
  double get toDouble {
    final value = _value;
    if (value is double) {
      return value;
    }
    return double.parse('$value');
  }
  //
  @override
  int get toInt {
    final value = _value;
    if (value is int) {
      return value;
    }
    return double.parse('$value').toInt();
  }
  //
  @override
  String toString() => '$_value';
}