import 'localizations.dart';

class Localized {
  final String _text;
  ///
  /// Translates 
  const Localized(String text) : _text = text;
  ///
  @override
  String toString() => Localizations.getTranslation(_text);
  ///
  /// alias for toString
  /// - returns translation for current lang 
  String get v => toString();
}