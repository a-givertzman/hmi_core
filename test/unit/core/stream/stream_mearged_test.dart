import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
  const debug = true;
  final values1 = [1.1, 1.2, 1.3, 1.4, 1.5, 1.0];
  final values2 = [2.1, 2.2, 2.3, 2.4, 2.5, 2.0];
  final values3 = [3.1, 3.2, 3.3, 3.4, 3.5, 3.0];
  group('StreamMerged', () {
    test('create', () {
      final streamController1 = StreamController<double>();
      final streamController2 = StreamController<double>();
      final streamController3 = StreamController<double>();
      final streamMearged = StreamMerged<double>([
        streamController1.stream,
        streamController2.stream,
        streamController3.stream,
      ]);
      expect(streamMearged, isInstanceOf<StreamMerged<double>>());
    });
    test('1 of 3 stream handling', () async {
      final streamController1 = StreamController<double>();
      final streamController2 = StreamController<double>();
      final streamController3 = StreamController<double>();
      final streamMearged = StreamMerged<double>([
        streamController1.stream,
        streamController2.stream,
        streamController3.stream,
      ]);
      var done1 = false;
      final resultList = <double>[];
      streamMearged.stream.listen((event) {
        log(debug, '1 of 3: event: ', event);
        resultList.add(event);
        if (event == 1.0) {
          done1 = true;
        }
      });
      for (final value in values1) {
        streamController1.add(value);
      }
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 1));
        return !done1;
      });
      expect(resultList, equals(values1));
    });
    test('2 of 3 stream handling', () async {
      final streamController1 = StreamController<double>();
      final streamController2 = StreamController<double>();
      final streamController3 = StreamController<double>();
      final streamMearged = StreamMerged<double>([
        streamController1.stream,
        streamController2.stream,
        streamController3.stream,
      ]);
      var done21 = false;
      var done22 = false;
      final resultList = <double>[];
      streamMearged.stream.listen((event) {
        log(debug, '2 of 3: event: ', event);
        resultList.add(event);
        if (event == 1.0) {
          done21 = true;
        }
        if (event == 2.0) {
          done22 = true;
        }
      });
      for (final value in values1) {
        streamController1.add(value);
      }
      for (final value in values2) {
        streamController2.add(value);
      }
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 1));
        return !done21 || !done22;
      });
      final resultSet = Set.of(resultList);
      expect(resultSet.containsAll(values1), equals(true));
      expect(resultSet.containsAll(values2), equals(true));
    });
    test('3 of 3 stream handling', () async {
      final streamController1 = StreamController<double>();
      final streamController2 = StreamController<double>();
      final streamController3 = StreamController<double>();
      final streamMearged = StreamMerged<double>([
        streamController1.stream,
        streamController2.stream,
        streamController3.stream,
      ]);
      var done31 = false;
      var done32 = false;
      var done33 = false;
      final resultList = <double>[];
      streamMearged.stream.listen((event) {
        log(debug, '3 of 3: event: ', event);
        resultList.add(event);
        if (event == 1.0) {
          done31 = true;
        }
        if (event == 2.0) {
          done32 = true;
        }
        if (event == 3.0) {
          done33 = true;
        }
      });
      for (final value in values1) {
        streamController1.add(value);
      }
      for (final value in values2) {
        streamController2.add(value);
      }
      for (final value in values3) {
        streamController3.add(value);
      }
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 1));
        return !done31 || !done32 || !done33;
      });
      final resultSet = Set.of(resultList);
      expect(resultSet.containsAll(values1), equals(true));
      expect(resultSet.containsAll(values2), equals(true));
      expect(resultSet.containsAll(values3), equals(true));
    });
    test('stream with external handler', () async {
      final rightList = [];
      final streamController1 = StreamController<double>();
      final streamController2 = StreamController<double>();
      final streamController3 = StreamController<double>();
      final streamMearged = StreamMerged<double>([
        streamController1.stream,
        streamController2.stream,
        streamController3.stream,
      ], handler: (values) {
        if (values[0] != null && values[1] != null && values[2] != null) {
          log(debug, '${values[0]} * ${values[1]} - ${values[2]} = ', values[0]! * values[1]! - values[2]!);
          rightList.add(values[0]! * values[1]! - values[2]!);
          return values[0]! * values[1]! - values[2]!;
        }
        log(debug, '${values[0]} * ${values[1]} - ${values[2]} = 0.0');
        rightList.add(0.0);
        return 0;
      },);      
      var done4 = false;
      final resultList = <double>[];
      streamMearged.stream.listen((event) {
        log(debug, '4: event: ', event);
        resultList.add(event);
      },
      onDone: () {
        done4 = true;
      },
      );
      for (final value in values1) {
        streamController1.add(value);
      }
      streamController1.close();
      for (final value in values2) {
        streamController2.add(value);
      }
      streamController2.close();
      for (final value in values3) {
        streamController3.add(value);
      }
      streamController3.close();
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 1));
        return !done4;
      });
      final resultSet = Set.of(resultList);
      expect(resultSet.containsAll(rightList), equals(true));
      final rightSet = Set.of(rightList);
      expect(rightSet.containsAll(resultSet), equals(true));
    });
  },);
}
