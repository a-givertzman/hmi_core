import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:hmi_core/src/core/result_new/extension_boolean_operations.dart';
//
void main() {
  //
  group(
    'Result BooleanOperations extension and',
    () {
      //
      test(
        'returns Result',
        () {
          const ok = Ok<int, String>(1);
          const err = Err<int, String>('error');
          expect(ok.and(const Ok(1)), isA<Result>());
          expect(ok.and(const Err('error')), isA<Result>());
          expect(err.and(const Ok(1)), isA<Result>());
          expect(err.and(const Err('error')), isA<Result>());
        },
      );
      //
      test(
        'returns passed `result` if the result is Ok',
        () {
          final resultList = <Map<String, dynamic>>[
            {
              'before': const Ok(1),
              'after': const Ok(2),
              'result': const Ok(2),
            }, // Ok(int) -> Ok(int)
            {
              'before': const Ok(1.0),
              'after': const Ok(true),
              'result': const Ok(true),
            }, // Ok(double) -> Ok(bool)
            {
              'before': const Ok('1'),
              'after': const Err('2'),
              'result': const Err('2'),
            }, // Ok(String) -> Err(String)
            {
              'before': const Ok(true),
              'after': const Ok(false),
              'result': const Ok(false),
            }, // Ok(bool) -> Ok(bool)
            {
              'before': const Ok(null),
              'after': const Err(null),
              'result': const Err(null),
            }, // Ok(null) -> Err(null)
          ];
          for (final result in resultList) {
            final (before, after, result_) = (
              result['before'] as Ok,
              result['after'] as Result,
              result['result'] as Result
            );
            final andResult = before.and(after);
            expect(andResult, isA<Result>());
            switch (result_) {
              case Ok(:final value):
                expect(andResult, isA<Ok>());
                expect((andResult as Ok).value, equals(value));
                break;
              case Err(:final error):
                expect(andResult, isA<Err>());
                expect((andResult as Err).error, equals(error));
                break;
            }
          }
        },
      );
      //
      test(
        'returns Err with untouched value for Err',
        () {
          const resultList = <(Err, dynamic)>[
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
            final andResult = err.and(const Ok(null));
            expect(andResult, isA<Err>());
            expect((andResult as Err).error, equals(err.error));
          }
        },
      );
    },
  );
  //
  group(
    'Result BooleanOperations extension andThen',
    () {
      //
      test(
        'returns Result',
        () {
          const ok = Ok(1);
          const err = Err('error');
          expect(ok.andThen((value) => Ok(value)), isA<Result>());
          expect(err.andThen((value) => Ok(value)), isA<Result>());
        },
      );
      //
      test(
        'returns Result of op for Ok and Err for Err',
        () {
          const ok = Ok(1);
          const err = Err('error');
          expect(ok.andThen((value) => Ok(value)), isA<Ok>());
          expect(ok.andThen((value) => Err(value)), isA<Err>());
          expect(err.andThen((value) => Ok(value)), isA<Err>());
          expect(err.andThen((value) => Err(value)), isA<Err>());
        },
      );
      //
      test(
        'returns Ok with new value by applying op to original Ok value',
        () {
          final resultList = <Map<String, dynamic>>[
            {
              'before': const Ok(1),
              'after': const Ok(2),
              'op': (value) => Ok(value + 1),
            }, // int -> int
            {
              'before': const Ok(1.0),
              'after': const Ok(true),
              'op': (value) => Ok(value > 0),
            }, // double -> bool
            {
              'before': const Ok('1'),
              'after': const Ok('2'),
              'op': (value) => Ok('${int.parse(value) + 1}'),
            }, // String -> String
            {
              'before': const Ok(true),
              'after': const Ok(false),
              'op': (value) => Ok(!value),
            }, // bool -> bool
            {
              'before': const Ok(null),
              'after': const Ok(null),
              'op': (value) => Ok(value),
            }, // null -> null
          ];
          for (final result in resultList) {
            final (before, after, op) = (
              result['before'] as Ok,
              result['after'] as Ok,
              result['op'] as Result Function(dynamic),
            );
            final andThenResult = before.andThen(op);
            expect(andThenResult, isA<Ok>());
            expect((andThenResult as Ok).value, equals(after.value));
          }
        },
      );
      //
      test(
        'returns Err with new value by applying op to original Ok value',
        () {
          final resultList = <Map<String, dynamic>>[
            {
              'before': const Ok(1),
              'after': const Err(2),
              'op': (value) => Err(value + 1),
            }, // int -> int
            {
              'before': const Ok(1.0),
              'after': const Err(true),
              'op': (value) => Err(value > 0),
            }, // double -> bool
            {
              'before': const Ok('1'),
              'after': const Err('2'),
              'op': (value) => Err('${int.parse(value) + 1}'),
            }, // String -> String
            {
              'before': const Ok(true),
              'after': const Err(false),
              'op': (value) => Err(!value),
            }, // bool -> bool
            {
              'before': const Ok(null),
              'after': const Err(null),
              'op': (value) => Err(value),
            }, // null -> null
          ];
          for (final result in resultList) {
            final (before, after, op) = (
              result['before'] as Ok,
              result['after'] as Err,
              result['op'] as Result Function(dynamic),
            );
            final andThenResult = before.andThen(op);
            expect(andThenResult, isA<Err>());
            expect((andThenResult as Err).error, equals(after.error));
          }
        },
      );
      //
      test(
        'returns Err with untouched value for Err',
        () {
          const resultList = <(Err, dynamic)>[
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
            final andThenResult = err.andThen((value) => Ok(value));
            expect(andThenResult, isA<Err>());
            expect((andThenResult as Err).error, equals(err.error));
          }
        },
      );
    },
  );
  group(
    'Result BooleanOperations extension or',
    () {
      //
      test(
        'returns Result',
        () {
          const ok = Ok<int, String>(1);
          const err = Err<int, String>('error');
          expect(ok.or(const Ok(1)), isA<Result>());
          expect(ok.or(const Err('error')), isA<Result>());
          expect(err.or(const Ok(1)), isA<Result>());
          expect(err.or(const Err('error')), isA<Result>());
        },
      );
      //
      test(
        'returns passed `result` if the result is Err',
        () {
          final resultList = <Map<String, dynamic>>[
            {
              'before': const Err(1),
              'after': const Ok(2),
              'result': const Ok(2),
            }, // Err(int) -> Ok(int)
            {
              'before': const Err(1.0),
              'after': const Ok(true),
              'result': const Ok(true),
            }, // Err(double) -> Ok(bool)
            {
              'before': const Err('1'),
              'after': const Err('2'),
              'result': const Err('2'),
            }, // Err(String) -> Err(String)
            {
              'before': const Err(true),
              'after': const Ok(false),
              'result': const Ok(false),
            }, // Err(bool) -> Ok(bool)
            {
              'before': const Err(null),
              'after': const Err(null),
              'result': const Err(null),
            }, // Err(null) -> Err(null)
          ];
          for (final result in resultList) {
            final (before, after, result_) = (
              result['before'] as Err,
              result['after'] as Result,
              result['result'] as Result
            );
            final orResult = before.or(after);
            expect(orResult, isA<Result>());
            switch (result_) {
              case Ok(:final value):
                expect(orResult, isA<Ok>());
                expect((orResult as Ok).value, equals(value));
                break;
              case Err(:final error):
                expect(orResult, isA<Err>());
                expect((orResult as Err).error, equals(error));
                break;
            }
          }
        },
      );
      //
      test(
        'returns Ok with untouched value for Ok',
        () {
          const resultList = <(Ok, dynamic)>[
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
            final orResult = ok.or(const Err(null));
            expect(orResult, isA<Ok>());
            expect((orResult as Ok).value, equals(ok.value));
          }
        },
      );
    },
  );
  //
  group(
    'Result BooleanOperations extension orElse',
    () {
      //
      test(
        'returns Result',
        () {
          const ok = Ok(1);
          const err = Err('error');
          expect(ok.orElse((error) => Ok(error)), isA<Result>());
          expect(err.orElse((error) => Ok(error)), isA<Result>());
        },
      );
      //
      test(
        'returns Ok for Ok and Result of orElse for Err',
        () {
          const ok = Ok(1);
          const err = Err('error');
          expect(ok.orElse((error) => Ok(error)), isA<Ok>());
          expect(ok.orElse((error) => Err(error)), isA<Ok>());
          expect(err.orElse((error) => Ok(error)), isA<Ok>());
          expect(err.orElse((error) => Err(error)), isA<Err>());
        },
      );
      //
      test(
        'returns Ok with new value by applying orElse to original Err error',
        () {
          final resultList = <Map<String, dynamic>>[
            {
              'before': const Err(1),
              'after': const Ok(2),
              'orElse': (error) => Ok(error + 1),
            }, // int -> int
            {
              'before': const Err(1.0),
              'after': const Ok(true),
              'orElse': (error) => Ok(error > 0),
            }, // double -> bool
            {
              'before': const Err('1'),
              'after': const Ok('2'),
              'orElse': (error) => Ok('${int.parse(error) + 1}'),
            }, // String -> String
            {
              'before': const Err(true),
              'after': const Ok(false),
              'orElse': (error) => Ok(!error),
            }, // bool -> bool
            {
              'before': const Err(null),
              'after': const Ok(null),
              'orElse': (error) => Ok(error),
            }, // null -> null
          ];
          for (final result in resultList) {
            final (before, after, orElse) = (
              result['before'] as Err,
              result['after'] as Ok,
              result['orElse'] as Result Function(dynamic),
            );
            final orElseResult = before.orElse(orElse);
            expect(orElseResult, isA<Ok>());
            expect((orElseResult as Ok).value, equals(after.value));
          }
        },
      );
      //
      test(
        'returns Err with new value by applying orElse to original Err error',
        () {
          final resultList = <Map<String, dynamic>>[
            {
              'before': const Err(1),
              'after': const Err(2),
              'orElse': (error) => Err(error + 1),
            }, // int -> int
            {
              'before': const Err(1.0),
              'after': const Err(true),
              'orElse': (error) => Err(error > 0),
            }, // double -> bool
            {
              'before': const Err('1'),
              'after': const Err('2'),
              'orElse': (error) => Err('${int.parse(error) + 1}'),
            }, // String -> String
            {
              'before': const Err(true),
              'after': const Err(false),
              'orElse': (error) => Err(!error),
            }, // bool -> bool
            {
              'before': const Err(null),
              'after': const Err(null),
              'orElse': (error) => Err(error),
            }, // null -> null
          ];
          for (final result in resultList) {
            final (before, after, orElse) = (
              result['before'] as Err,
              result['after'] as Err,
              result['orElse'] as Result Function(dynamic),
            );
            final orElseResult = before.orElse(orElse);
            expect(orElseResult, isA<Err>());
            expect((orElseResult as Err).error, equals(after.error));
          }
        },
      );
      //
      test(
        'returns Ok with untouched value for Ok',
        () {
          const resultList = <(Ok, dynamic)>[
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
            final orElseResult = ok.orElse((error) => Err(error));
            expect(orElseResult, isA<Ok>());
            expect((orElseResult as Ok).value, equals(ok.value));
          }
        },
      );
    },
  );
}
