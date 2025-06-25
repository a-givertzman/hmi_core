import 'app_settings.dart';
import 'package:hmi_core/src/core/error/failure.dart';
///
/// Holds setting value stored in [AppSettings] by it name.
///
/// Value can be returned in int, double or string representation.
class Setting {
  final String _name;
  final double _factor;
  final dynamic Function(Failure err)? _onError;
  ///
  /// Holds setting value stored in [AppSettings] by it [name].
  ///
  /// Value can be returned in int, double or string representation.
  /// [int] and [double] values are multiplied by [factor] before returning.
  ///
  /// Calls [onError] if getting value from [AppSettings] will fail.
  const Setting(
    String name, {
    double factor = 1.0,
    dynamic Function(Failure err)? onError,
  })  : _name = name,
        _factor = factor,
        _onError = onError;
  ///
  /// Returns [Setting] new instance containing a [value]
  const factory Setting.from(dynamic value) = _SettingValue;
  ///
  /// Returns setting value in [int] representation
  int get toInt {
    final value = AppSettings.getSetting(_name, onError: _onError);
    if (value is int) {
      return _factor == 1 ? value : (value * _factor).toInt();
    }
    return (double.parse('$value') * _factor).toInt();
  }
  ///
  /// Returns setting value in [double] representation
  double get toDouble {
    final value = AppSettings.getSetting(_name, onError: _onError);
    if (value is double) {
      return value * _factor;
    }
    return double.parse('$value') * _factor;
  }
  ///
  /// Updates app setting to new [value] and save it asynchronously to file.
  ///
  /// Calls [onSuccess] or [onError] when setting will be updated
  /// and saved successfully or with error.
  Future<void> update(
    dynamic value, {
    void Function(Failure error)? onError,
    void Function()? onSuccess,
  }) async {
    await AppSettings.setSetting(
      _name,
      value,
      onError: onError,
      onSuccess: onSuccess,
    );
  }
  ///
  /// Returns setting value in [String] representation
  @override
  String toString() => '${AppSettings.getSetting(_name, onError: _onError)}';
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
  Future<void> update(
    dynamic value, {
    void Function(Failure error)? onError,
    void Function()? onSuccess,
  }) async {
    onError?.call(Failure('$runtimeType.update | Cannot update setting created during app runtime'));
  }
  //
  @override
  String toString() => '$_value';
}
