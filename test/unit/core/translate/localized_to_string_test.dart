import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
  test('Localized toString', () async {
    final translationData = [
      {
        'input': 'Crane monitoring',
        'translation':'Диагностика крана',
      },
      {
        'input': 'Harbour',
        'translation':'В порту',
      },
      {
        'input': 'Winch 3',
        'translation': 'Лебедка 3',
      },
      {
        'input': 'Knukle jib',
        'translation': 'Хобот',
      },
      {
        'input': 'Basic protections',
        'translation':'Основные защиты',
      },
      {
        'input': 'High pressure accumulator',
        'translation':'Аккумулятор высокого давления',
      },
      {
        'input': 'Text that has never been localized',
        'translation': 'Text that has never been localized',
      },
    ]; 
    for(final entry in translationData) {
      final input = entry['input']!;
      final translation = entry['translation']!;
      expect(Localized(input).toString(), translation);
      expect(Localized(input, lang: AppLang.ru).toString(), translation);
      expect(Localized(input, lang: AppLang.en).toString(), input);
    }
  });
}