import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
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
      'en_text': 'Knukle jib',
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
    test('translates text if translation exists', () async {
      for(final entry in translatedItems) {
        final englishText = entry['en_text']!;
        final russianText = entry['ru_text']!;
        expect(
          Localized(englishText).toString(), 
          russianText,
          reason: 'Wrong translation to default language!',
        );
        expect(
          Localized(englishText, lang: AppLang.ru).toString(), 
          russianText,
          reason: 'Wrong translation to russian language!',
        );
        expect(
          Localized(englishText, lang: AppLang.en).toString(), 
          englishText,
          reason: 'Wrong translation to english language!',
        );
      }
    });
    test('throws if translation does not exist', () async {
      for(final entry in notTranslatedItems) {
        final englishText = entry['not_translated_text']!;
        expect(
          () => Localized(englishText).toString(), 
          throwsA(isA<Failure>()),
          reason: 'Wrong translation to default language!',
        );
        expect(
          () => Localized(englishText, lang: AppLang.ru).toString(), 
          throwsA(isA<Failure>()),
          reason: 'Wrong translation to russian language!',
        );
        expect(
          () => Localized(englishText, lang: AppLang.en).toString(), 
          throwsA(isA<Failure>()),
          reason: 'Wrong translation to english language!',
        );
      }
    });
  });
}