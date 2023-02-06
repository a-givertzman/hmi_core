import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
  test('Localized toString', () async {
    final translationData = [
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
      {
        'en_text': 'Text that has never been localized',
        'ru_text': 'Text that has never been localized',
      },
      {
        'en_text': 'Непереведённый текст',
        'ru_text': 'Непереведённый текст',
      },
      {
        'en_text': '1234567890-=!"№;%:?*()_+',
        'ru_text': '1234567890-=!"№;%:?*()_+',
      },
    ]; 
    for(final entry in translationData) {
      final englishText = entry['en_text']!;
      final russianText = entry['ru_text']!;
      expect(
        Localized(englishText).toString(), 
        russianText,
        reason: 'Wrong translation to default language!'
      );
      expect(
        Localized(englishText, lang: AppLang.ru).toString(), 
        russianText,
        reason: 'Wrong translation to russian language!'
      );
      expect(
        Localized(englishText, lang: AppLang.en).toString(), 
        englishText,
        reason: 'Wrong translation to english language!'
      );
    }
  });
}