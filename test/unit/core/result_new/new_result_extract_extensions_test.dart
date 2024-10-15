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
          const resultList = <(Ok<dynamic, Never>, dynamic)>[
            (Ok(1), 1), // int
            (Ok(1.0), 1.0), // double
            (Ok('1'), '1'), // String
            (Ok(true), true), // bool
            (Ok(null), null), // null
            (Ok([1, 2, 3]), [1, 2, 3]), // List
            (Ok({'a': 1, 'b': 2}), {'a': 1, 'b': 2}), // Map
          ];
          for (final result in resultList) {
            final (ok, value) = result;
            final intoOkValue = ok.intoOk();
            expect(intoOkValue, equals(value));
          }
        },
      );
    },
  );
  //
  group(
    'Result ExtractErr extension',
    () {
      test(
        'intoOk returns the contained Ok value',
        () {
          const resultList = <(Err<Never, dynamic>, dynamic)>[
            (Err(1), 1), // int
            (Err(1.0), 1.0), // double
            (Err('1'), '1'), // String
            (Err(true), true), // bool
            (Err(null), null), // null
            (Err([1, 2, 3]), [1, 2, 3]), // List
            (Err({'a': 1, 'b': 2}), {'a': 1, 'b': 2}), // Map
          ];
          for (final result in resultList) {
            final (err, value) = result;
            final intoErrValue = err.intoErr();
            expect(intoErrValue, equals(value));
          }
        },
      );
    },
  );
}
