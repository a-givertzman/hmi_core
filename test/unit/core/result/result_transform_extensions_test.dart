import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_result.dart';
import 'package:hmi_core/src/core/result/extension_transform.dart';
//
void main() {
  //
  group(
    'Result Transform extension map method',
    () {
      //
      test(
        'returns Ok for Ok and Err for Err',
        () {
          const ok = Ok(1);
          const err = Err('error');
          expect(ok.map((value) => value), isA<Ok>());
          expect(err.map((value) => value), isA<Err>());
        },
      );
      //
      test(
        'returns mapped Ok value for Ok',
        () {
          final testCaseList = <Map<String, dynamic>>[
            {
              'before': const Ok(1),
              'after': const Ok(2),
              'mapFunction': (value) => value + 1,
            }, // int
            {
              'before': const Ok(1.0),
              'after': const Ok(true),
              'mapFunction': (value) => value > 0,
            }, // double
            {
              'before': const Ok('1'),
              'after': const Ok('2'),
              'mapFunction': (value) => '${int.parse(value) + 1}',
            }, // String
            {
              'before': const Ok(true),
              'after': const Ok(false),
              'mapFunction': (value) => !value,
            }, // bool
            {
              'before': const Ok(null),
              'after': const Ok(null),
              'mapFunction': (value) => value,
            }, // null
          ];
          for (final testCase in testCaseList) {
            final (before, after, mapFunction) = (
              testCase['before'] as Ok,
              testCase['after'] as Ok,
              testCase['mapFunction'] as dynamic Function(dynamic),
            );
            final mapped = before.map(mapFunction);
            expect(mapped, isA<Ok>());
            expect((mapped as Ok).value, equals(after.value));
          }
        },
      );
      //
      test(
        'returns Err with untouched value for Err',
        () {
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
            final mappedErr = err.map((value) => value + 1);
            expect(mappedErr, isA<Err>());
            expect((mappedErr as Err).error, equals(value));
          }
        },
      );
    },
  );
  //
  group(
    'Result Transform extension mapOr method',
    () {
      //
      test(
        'returns mapped value for Ok',
        () {
          final testCaseList = <Map<String, dynamic>>[
            {
              'before': const Ok(1),
              'after': 2,
              'mapFunction': (value) => value + 1,
            }, // int
            {
              'before': const Ok(1.0),
              'after': true,
              'mapFunction': (value) => value > 0,
            }, // double
            {
              'before': const Ok('1'),
              'after': '2',
              'mapFunction': (value) => '${int.parse(value) + 1}',
            }, // String
            {
              'before': const Ok(true),
              'after': false,
              'mapFunction': (value) => !value,
            }, // bool
            {
              'before': const Ok(null),
              'after': null,
              'mapFunction': (value) => value,
            }, // null
          ];
          for (final testCase in testCaseList) {
            final (before, after, mapFunction) = (
              testCase['before'] as Ok,
              testCase['after'] as dynamic,
              testCase['mapFunction'] as dynamic Function(dynamic),
            );
            final mapped = before.mapOr(before, mapFunction);
            expect(mapped, equals(after));
          }
        },
      );
      //
      test(
        'returns default value for Err',
        () {
          final testCaseList = <Map<String, dynamic>>[
            {
              'before': const Err(1),
              'mapFunction': (value) => value + 1,
              'default': -1,
            }, // int
            {
              'before': const Err(1.0),
              'mapFunction': (value) => value > 0,
              'default': false,
            }, // double
            {
              'before': const Err('1'),
              'mapFunction': (value) => '${int.parse(value) + 1}',
              'default': '-1',
            }, // String
            {
              'before': const Err(true),
              'mapFunction': (value) => !value,
              'default': true,
            }, // bool
          ];
          for (final testCase in testCaseList) {
            final (before, mapFunction, defaultValue) = (
              testCase['before'] as Err,
              testCase['mapFunction'] as dynamic Function(dynamic),
              testCase['default'] as dynamic,
            );
            final mapped = before.mapOr(defaultValue, mapFunction);
            expect(mapped, equals(defaultValue));
          }
        },
      );
    },
  );
  //
  group(
    'Result Transform extension mapOrElse method',
    () {
      //
      test(
        'returns value returned by function for Ok',
        () {
          final testCaseList = <Map<String, dynamic>>[
            {
              'before': const Ok(1),
              'after': 2,
              'mapFunction': (value) => value + 1,
              'elseFunction': (value) => value - 2,
            }, // int
            {
              'before': const Ok(1.0),
              'after': true,
              'mapFunction': (value) => value > 0,
              'elseFunction': (value) => value < 0,
            }, // double
            {
              'before': const Ok('1'),
              'after': '2',
              'mapFunction': (value) => '${int.parse(value) + 1}',
              'elseFunction': (value) => '${int.parse(value) - -2}',
            }, // String
            {
              'before': const Ok(true),
              'after': false,
              'mapFunction': (value) => !value,
              'elseFunction': (value) => value,
            }, // bool
          ];
          for (final testCase in testCaseList) {
            final (before, after, mapFunction, elseFunction) = (
              testCase['before'] as Ok,
              testCase['after'] as dynamic,
              testCase['mapFunction'] as dynamic Function(dynamic),
              testCase['elseFunction'] as dynamic Function(dynamic),
            );
            final mapped = before.mapOrElse(elseFunction, mapFunction);
            expect(mapped, equals(after));
          }
        },
      );
      //
      test(
        'returns value returned by fallback function for Err',
        () {
          final testCaseList = <Map<String, dynamic>>[
            {
              'before': const Err(1),
              'after': -1,
              'mapFunction': (value) => value + 1,
              'elseFunction': (value) => value - 2,
            }, // int
            {
              'before': const Err(1.0),
              'after': false,
              'mapFunction': (value) => value > 0,
              'elseFunction': (value) => value < 0,
            }, // double
            {
              'before': const Err('1'),
              'after': '-1',
              'mapFunction': (value) => '${int.parse(value) + 1}',
              'elseFunction': (value) => '${int.parse(value) - 2}',
            }, // String
            {
              'before': const Err(true),
              'after': true,
              'mapFunction': (value) => !value,
              'elseFunction': (value) => value,
            }, // bool
          ];
          for (final testCase in testCaseList) {
            final (before, after, mapFunction, elseFunction) = (
              testCase['before'] as Err,
              testCase['after'] as dynamic,
              testCase['mapFunction'] as dynamic Function(dynamic),
              testCase['elseFunction'] as dynamic Function(dynamic),
            );
            final mapped = before.mapOrElse(elseFunction, mapFunction);
            expect(mapped, equals(after));
          }
        },
      );
    },
  );
  //
  group(
    'Result Transform extension mapErr method',
    () {
      //
      test(
        'returns Ok for Ok and Err for Err',
        () {
          const ok = Ok(1);
          const err = Err('error');
          expect(ok.mapErr((value) => value), isA<Ok>());
          expect(err.mapErr((value) => value), isA<Err>());
        },
      );
      //
      test(
        'returns mapped Err for Err',
        () {
          final testCaseList = <Map<String, dynamic>>[
            {
              'before': const Err(1),
              'after': const Err(2),
              'mapFunction': (value) => value + 1,
            }, // int
            {
              'before': const Err(1.0),
              'after': const Err(true),
              'mapFunction': (value) => value > 0,
            }, // double
            {
              'before': const Err('1'),
              'after': const Err('2'),
              'mapFunction': (value) => '${int.parse(value) + 1}',
            }, // String
            {
              'before': const Err(true),
              'after': const Err(false),
              'mapFunction': (value) => !value,
            }, // bool
            {
              'before': const Err(null),
              'after': const Err(null),
              'mapFunction': (value) => value,
            }, // null
          ];
          for (final testCase in testCaseList) {
            final (before, after, mapFunction) = (
              testCase['before'] as Err,
              testCase['after'] as Err,
              testCase['mapFunction'] as dynamic Function(dynamic),
            );
            final mapped = before.mapErr(mapFunction);
            expect(mapped, isA<Err>());
            expect((mapped as Err).error, equals(after.error));
          }
        },
      );
      //
      test(
        'returns Ok with untouched value for Ok',
        () {
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
            final mappedOk = ok.mapErr((value) => value + 1);
            expect(mappedOk, isA<Ok>());
            expect((mappedOk as Ok).value, equals(value));
          }
        },
      );
    },
  );
  //
  group(
    'Result Transform extension inspect method',
    () {
      //
      test(
        'calls the function with the contained value if the result is Ok',
        () {
          const ok = Ok(1);
          var called = false;
          ok.inspect(
            (value) {
              expect(value, equals(1));
              called = true;
            },
          );
          expect(called, isTrue);
        },
      );
      //
      test(
        'does not call the function if the result is Err',
        () {
          const err = Err('error');
          var called = false;
          err.inspect(
            (value) {
              called = true;
            },
          );
          expect(called, isFalse);
        },
      );
      //
      test(
        'returns the original result if the result is Ok',
        () {
          const ok = Ok(1);
          final result = ok.inspect(
            (value) {
              return;
            },
          );
          expect(result, equals(ok));
        },
      );
      //
      test(
        'returns the original result if the result is Err',
        () {
          const err = Err(1);
          final result = err.inspect(
            (value) {
              return;
            },
          );
          expect(result, equals(err));
        },
      );
    },
  );
  //
  group(
    'Result Transform extension inspectErr method',
    () {
      //
      test(
        'calls the function with the contained error if the result is Err',
        () {
          const err = Err('error');
          var called = false;
          err.inspectErr(
            (error) {
              expect(error, equals('error'));
              called = true;
            },
          );
          expect(called, isTrue);
        },
      );
      //
      test(
        'does not call the function if the result is Ok',
        () {
          const ok = Ok(1);
          var called = false;
          ok.inspectErr(
            (error) {
              called = true;
            },
          );
          expect(called, isFalse);
        },
      );
      //
      test(
        'returns the original result if the result is Ok',
        () {
          const ok = Ok(1);
          final result = ok.inspectErr((error) {
            return;
          });
          expect(result, equals(ok));
        },
      );
      //
      test(
        'returns the original result if the result is Err',
        () {
          const err = Err(1);
          final result = err.inspectErr((error) {
            return;
          });
          expect(result, equals(err));
        },
      );
    },
  );
}
