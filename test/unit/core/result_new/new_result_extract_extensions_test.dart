import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:hmi_core/src/core/result_new/extension_extract.dart';
//
void main() {
  //
  group(
    'Result Extract extension',
    () {
      //
      test(
        'unwrapOr returns the contained Ok value or the default value for Err',
        () {
          const ok = Ok(1);
          const err = Err<int, String>('error');
          expect(ok.unwrapOr(2), equals(1));
          expect(err.unwrapOr(2), equals(2));
        },
      );
      //
      test(
        'unwrapOrElse returns the contained Ok value or the computed value for Err',
        () {
          const ok = Ok(1);
          const err = Err<int, String>('error');
          expect(ok.unwrapOrElse((_) => 5), equals(1));
          expect(err.unwrapOrElse((error) => error.length), equals(5));
        },
      );
    },
  );
  //
  group(
    'Result ExtractOk extension',
    () {
      //
      test(
        'intoOk returns the contained Ok value',
        () {
          const ok = Ok<int, Never>(1);
          expect(ok.intoOk(), equals(1));
        },
      );
    },
  );
  //
  group(
    'Result ExtractErr extension',
    () {
      //
      test(
        'intoErr returns the contained Err value',
        () {
          const err = Err<Never, String>('error');
          expect(err.intoErr(), equals('error'));
        },
      );
    },
  );
}
