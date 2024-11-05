import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_result.dart';
import 'package:hmi_core/src/core/result/extension_querying.dart';
//
void main() {
  //
  group(
    'Result Querying extension',
    () {
      //
      test(
        'isOk method returns true for Ok and false for Err',
        () {
          const ok = Ok(1);
          const err = Err(1);
          expect(ok.isOk(), isTrue);
          expect(err.isOk(), isFalse);
        },
      );
      //
      test(
        'isOkAnd method returns true if the predicate matches and false otherwise for Ok',
        () {
          const ok = Ok(1);
          expect(ok.isOkAnd((value) => value == 1), isTrue);
          expect(ok.isOkAnd((value) => value == 2), isFalse);
        },
      );
      //
      test(
        'isOkAnd method always returns false for Err',
        () {
          const err = Err(1);
          expect(err.isOkAnd((value) => value == 1), isFalse);
          expect(err.isOkAnd((value) => value == 2), isFalse);
        },
      );
      //
      test(
        'isErr method returns true for Err and false for Ok',
        () {
          const ok = Ok(1);
          const err = Err(1);
          expect(ok.isErr(), isFalse);
          expect(err.isErr(), isTrue);
        },
      );
      //
      test(
        'isErrAnd method returns true if the predicate matches and false otherwise for Err',
        () {
          const err = Err(1);
          expect(err.isErrAnd((error) => error == 1), isTrue);
          expect(err.isErrAnd((error) => error == 2), isFalse);
        },
      );
      //
      test(
        'isErrAnd method always returns false for Ok',
        () {
          const ok = Ok(1);
          expect(ok.isErrAnd((value) => value == 1), isFalse);
          expect(ok.isErrAnd((value) => value == 2), isFalse);
        },
      );
    },
  );
}
