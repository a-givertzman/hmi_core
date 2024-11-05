import 'localizations.dart';
///
/// Translates [text] to the current application language
class Localized {
  final String _text;
  ///
  /// Translates [text] to the current application language
  const Localized(String text) : _text = text;
  ///
  @override
  String toString() => Localizations.getTranslation(_text);
  ///
  /// alias for toString
  /// - returns translation for current lang 
  String get v => toString();
}
///
/// Simple access to the localised
/// ```
/// ```
extension StringLocalize on String {
  ///
  /// Returns translated version of given `string` 
  String loc() {
    return Localizations.getTranslation(this);
  }
}
