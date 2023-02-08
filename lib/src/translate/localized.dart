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
