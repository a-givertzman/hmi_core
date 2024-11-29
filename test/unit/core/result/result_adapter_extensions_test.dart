import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_option.dart';
import 'package:hmi_core/hmi_core_result.dart';
//
void main() {
  //
  group('Result Adapter extension method', () {
    //
    test('ok returns Some for Ok and None for Err', () {
      const ok = Ok(1);
      const err = Err('error');
      expect(ok.ok(), isA<Some>());
      expect(err.ok(), isA<None>());
    });
    //
    test('ok returns Some with value inside for Ok', () {
      const testCaseList = <(Ok, dynamic)>[
        (Ok(1), 1), // int
        (Ok(1.0), 1.0), // double
        (Ok('1'), '1'), // String
        (Ok(true), true), // bool
        (Ok(null), null), // null
        (Ok([1, 2, 3]), [1, 2, 3]), // List
        (Ok({'a': 1, 'b': 2}), {'a': 1, 'b': 2}), // Map
      ];
      for (final testCase in testCaseList) {
        final (ok, value) = testCase;
        expect(ok.ok(), isA<Some>());
        expect((ok.ok() as Some).value, equals(value));
      }
    });
    //
    test('err returns Some for Err and None for Ok', () {
      const ok = Ok(1);
      const err = Err('error');
      expect(ok.err(), isA<None>());
      expect(err.err(), isA<Some>());
    });
    //
    test('err returns Some with value inside for Err', () {
      const testCaseList = <(Err, dynamic)>[
        (Err(1), 1), // int
        (Err(1.0), 1.0), // double
        (Err('1'), '1'), // String
        (Err(true), true), // bool
        (Err(null), null), // null
        (Err([1, 2, 3]), [1, 2, 3]), // List
        (Err({'a': 1, 'b': 2}), {'a': 1, 'b': 2}), // Map
      ];
      for (final testCase in testCaseList) {
        final (err, value) = testCase;
        expect(err.err(), isA<Some>());
        expect((err.err() as Some).value, equals(value));
      }
    });
  });
}
