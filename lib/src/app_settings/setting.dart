import 'app_settings.dart';

class Setting {
  final String _name;
  final double _factor;
  ///
  const Setting(
    String name, {
    double factor = 1.0
  }) : 
    _name = name,
    _factor = factor;
  /// 
  /// Returns setting value in int represantation
  int get toInt {
    final value = AppSettings.getSetting(_name);
    if (value is int) {
      return _factor == 1 ? value : (value * _factor).toInt();
    }
    return (double.parse('$value') * _factor).toInt();
  }
  /// 
  /// Returns setting value in double represantation
  double get toDouble {
    final value = AppSettings.getSetting(_name);
    if (value is double) {
      return value * _factor;
    }
    return double.parse('$value') * _factor;
  }
  /// 
  /// Returns setting value in string represantation
  @override
  String toString() {
    return '${AppSettings.getSetting(_name)}';
  }
}