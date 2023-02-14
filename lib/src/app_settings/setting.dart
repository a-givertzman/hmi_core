import 'app_settings.dart';

class Setting {
  final String _name;
  const Setting(String name) : _name = name;
  /// 
  /// Returns setting value in int represantation
  int get toInt {
    final value = AppSettings.getSetting(_name);
    if (value is int) {
      return value;
    }
    return double.parse('$value').toInt();
  }
  /// 
  /// Returns setting value in double represantation
  double get toDouble {
    final value = AppSettings.getSetting(_name);
    if (value is double) {
      return value;
    }
    return double.parse('$value');
  }
  /// 
  /// Returns setting value in string represantation
  @override
  String toString() {
    return '${AppSettings.getSetting(_name)}';
  }
}