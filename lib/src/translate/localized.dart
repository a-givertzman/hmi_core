import 'package:hmi_core/src/translate/app_lang.dart';

import 'localizations.dart';

class Localized {
  final String _text;
  final AppLang _lang;
  ///
  const Localized(String text, {
    AppLang lang = AppLang.ru,
  }) : _text = text,
    _lang = lang; 
  ///
  @override
  String toString() => Localizations.getTranslations(_text)[_lang.index];
}