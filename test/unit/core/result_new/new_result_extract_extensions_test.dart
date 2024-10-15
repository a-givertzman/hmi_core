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
        'unwrapOr returns the contained value for Ok',
        () {
          const testCaseList = <(Ok<dynamic, dynamic>, dynamic, dynamic)>[
            (Ok(1), 1, 2), // int
            (Ok(1.0), 1.0, 2.0), // double
            (Ok('1'), '1', '2'), // String
            (Ok(true), true, false), // bool
            (Ok([1, 2, 3]), [1, 2, 3], [-1, -2, -3]), // List
            (Ok({'a': 1, 'b': 2}), {'a': 1, 'b': 2}, {'y': -2, 'z': -1}), // Map
          ];
          for (final testCase in testCaseList) {
            final (ok, value, or) = testCase;
            final unwrapOrValue = ok.unwrapOr(or);
            expect(unwrapOrValue, equals(value));
          }
        },
      );
      //
      test(
        'unwrapOr returns the `or` value for Err',
        () {
          const testCaseList = <(Err<dynamic, dynamic>, dynamic, dynamic)>[
            (Err(1), 1, 2), // int
            (Err(1.0), 1.0, 2.0), // double
            (Err('1'), '1', '2'), // String
            (Err(true), true, false), // bool
            (Err([1, 2, 3]), [1, 2, 3], [-1, -2, -3]), // List
            (
              Err({'a': 1, 'b': 2}),
              {'a': 1, 'b': 2},
              {'y': -2, 'z': -1}
            ), // Map
          ];
          for (final testCase in testCaseList) {
            final (ok, value, or) = testCase;
            final unwrapOrValue = ok.unwrapOr(or);
            expect(unwrapOrValue, equals(or));
          }
        },
      );
      //
      test(
        'unwrapOrElse returns the contained value for Ok',
        () {
          final testCaseList = <Map<String, dynamic>>[
            {
              'before': const Ok(1),
              'after': 1,
              'elseFunction': (err) => err + 1,
            }, // int
            {
              'before': const Ok(1.0),
              'after': 1.0,
              'elseFunction': (err) => err + 1.0,
            }, // double
            {
              'before': const Ok('1'),
              'after': '1',
              'elseFunction': (err) => err + '1',
            }, // String
            {
              'before': const Ok(true),
              'after': true,
              'elseFunction': (err) => !err,
            }, // bool
            {
              'before': const Ok([1, 2, 3]),
              'after': [1, 2, 3],
              'elseFunction': (err) => err.reversed.toList(),
            }, // List
            ({
              'before': const Ok({'a': 1, 'b': 2}),
              'after': {'a': 1, 'b': 2},
              'elseFunction': (err) => {
                    for (var entry in err.entries) entry.key: -entry.value,
                  },
            }), // Map
          ];
          for (final testCase in testCaseList) {
            final (ok, value, elseFunction) = (
              testCase['before'] as Ok,
              testCase['after'] as dynamic,
              testCase['elseFunction'] as dynamic Function(dynamic),
            );
            final unwrapOrElseResult = ok.unwrapOrElse(elseFunction);
            expect(unwrapOrElseResult, equals(value));
          }
        },
      );
      //
      test(
        'unwrapOrElse returns the computed value for Err',
        () {
          final testCaseList = <Map<String, dynamic>>[
            {
              'before': const Err(1),
              'after': 2,
              'elseFunction': (err) => err + 1,
            }, // int
            {
              'before': const Err(1.0),
              'after': 2.0,
              'elseFunction': (err) => err + 1.0,
            }, // double
            {
              'before': const Err('1'),
              'after': '11',
              'elseFunction': (err) => err + '1',
            }, // String
            {
              'before': const Err(true),
              'after': false,
              'elseFunction': (err) => !err,
            }, // bool
            {
              'before': const Err([1, 2, 3]),
              'after': [3, 2, 1],
              'elseFunction': (err) => err.reversed.toList(),
            }, // List
            ({
              'before': const Err({'a': 1, 'b': 2}),
              'after': {'a': -1, 'b': -2},
              'elseFunction': (err) => {
                    for (var entry in err.entries) entry.key: -entry.value,
                  },
            }), // Map
          ];
          for (final testCase in testCaseList) {
            final (err, value, elseFunction) = (
              testCase['before'] as Err,
              testCase['after'] as dynamic,
              testCase['elseFunction'] as dynamic Function(dynamic),
            );
            final unwrapOrElseResult = err.unwrapOrElse(elseFunction);
            expect(unwrapOrElseResult, equals(value));
          }
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
          const testCaseList = <(Ok<dynamic, Never>, dynamic)>[
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
          const testCaseList = <(Err<Never, dynamic>, dynamic)>[
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
            final intoErrValue = err.intoErr();
            expect(intoErrValue, equals(value));
          }
        },
      );
    },
  );
}
