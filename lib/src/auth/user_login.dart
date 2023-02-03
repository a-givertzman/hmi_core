import 'package:hmi_core/src/core/validation_result.dart';

/// Класс хранит login пользователя
/// метод validate() возвращает положительный ValidationResult 
/// если длина 5...255 символов из ряда ^[A-Za-z][A-Za-z0-9_\.\-]{4,254}$
class UserLogin {
  final String _value;
  ///
  const UserLogin({
    required String value,
  }): 
    _value = value;
  ///
  ValidationResult validate({String message = 'Login must be..'}) {
    final regex = RegExp(r"^[A-Za-z0-9_\-.]{5,254}$");
    final valid = regex.hasMatch(_value);
    return ValidationResult(
      valid: valid,
      message: valid ? null : message,
    );
  }
  /// возвращает текст логина
  String value() => _value;
}
