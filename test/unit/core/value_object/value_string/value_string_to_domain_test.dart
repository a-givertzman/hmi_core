import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/value_object/value_string.dart';

void main() {
  group('ValueString toDomain()', () {
    const toDomainData = [
      {
        'initialString': 'abc',
        'domainString': '123sfgdfd',
      },
      {
        'initialString': 'wuopetlkjdsg',
        'domainString': 'xbcvpoxcv\$%^&*()',
      },
      {
        'initialString': 'hdfj',
        'domainString': '!@#\$%^&*()_+=-?<>,./\\|',
      },
      {
        'initialString': '',
        'domainString': 'dfgh',
      },
      {
        'initialString': ' ',
        'domainString': '',
      },
    ];
    test('returns new ValueString with different value', () {
      for(final entry in toDomainData) {
        final initialString = entry['initialString']!;
        final domainString = entry['domainString']!;
        final valueString = ValueString(initialString);
        final domain = valueString.toDomain(domainString);
        expect(valueString.value, initialString);
        expect(domain.value, domainString);
        expect(identical(domain, valueString), isFalse);
        expect(domain, isNot(equals(valueString)));
        expect(domain, isA<ValueString>());
      }
    });
    test('returns object equals to a ValueString with the same domain string', () {
      for(final entry in toDomainData) {
        final initialString = entry['initialString']!;
        final domainString = entry['domainString']!;
        final domain = ValueString(initialString).toDomain(domainString);
        final valueString = ValueString(domainString);
        expect(domain, equals(valueString));
      }
    });
  });
}