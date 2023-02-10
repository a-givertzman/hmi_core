import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() async {
  final translatedItems = [
    {
      'en_text': 'Crane monitoring',
      'ru_text':'Диагностика крана',
    },
    {
      'en_text': 'Harbour',
      'ru_text':'В порту',
    },
    {
      'en_text': 'Winch 3',
      'ru_text': 'Лебедка 3',
    },
    {
      'en_text': 'Knuckle jib',
      'ru_text': 'Хобот',
    },
    {
      'en_text': 'Basic protections',
      'ru_text':'Основные защиты',
    },
    {
      'en_text': 'High pressure accumulator',
      'ru_text':'Аккумулятор высокого давления',
    },
  ];
  final notTranslatedItems = [
    {
      'not_translated_text': 'Text that has never been localized',
    },
    {
      'not_translated_text': 'Непереведённый текст',
    },
    {
      'not_translated_text': '1234567890-=!"№;%:?*()_+',
    },
  ];
  group('Localized toString', () {
    setUpAll(() async {
      await Localizations.initialize(
        AppLang.ru,
        // TODO to be implemented
        // stringLoader: const StringLoader.fromAsset('tobeimplemented'),
      );
    });
    test('translates text if translation exists', () {
      for(final entry in translatedItems) {
        final englishText = entry['en_text']!;
        final russianText = entry['ru_text']!;
        expect(
          Localized(englishText).toString(), 
          russianText,
          reason: 'Wrong translation to custom ru language!',
        );
        expect(
          Localized(englishText).v, 
          russianText,
          reason: 'Wrong translation to custom ru language!',
        );
      }
    });
    test('returns origin if translation does not exist', () {
      for(final entry in notTranslatedItems) {
        final inputText = entry['not_translated_text']!;
        expect(
          Localized(inputText).v, 
          inputText,
          reason: 'Wrong origin to for input: "$inputText"!',
        );
        expect(
          Localized(inputText).toString(), 
          inputText,
          reason: 'Wrong origin to for input: "$inputText"!',
        );
      }
    });
  });
}