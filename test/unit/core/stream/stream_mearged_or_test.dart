import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
  const debug = true;
  final values1 = [1, 0, 1, 0, 1, 0];
  final values2 = [1, 0, 0, 1, 1, 0];
  final values3 = [0, 1, 1, 0, 1, 0];
  final mustResult2 = [1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0];
  final mustResult3 = [1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0];
  group('StreamMergedOr', () {
    ///
    test('create', () {
      final streamController1 = StreamController<DsDataPoint<bool>>();
      final streamController2 = StreamController<DsDataPoint<bool>>();
      final streamController3 = StreamController<DsDataPoint<bool>>();
      final streamMearged = StreamMergedOr([
        streamController1.stream,
        streamController2.stream,
        streamController3.stream,
      ]);
      expect(streamMearged, isInstanceOf<StreamMergedOr>());
    });
    ///
    test('1 of 3 stream handling', () async {
      final streamController1 = StreamController<DsDataPoint<bool>>();
      final streamController2 = StreamController<DsDataPoint<bool>>();
      final streamController3 = StreamController<DsDataPoint<bool>>();
      final streamMearged = StreamMergedOr([
        streamController1.stream,
        streamController2.stream,
        streamController3.stream,
      ]);
      var count = 0;
      final resultList = <int>[];
      streamMearged.stream.listen((event) {
        log(debug, '1 stream: event: ', event);
        resultList.add(event.value ? 1 : 0);
        count++;
      });
      for (final value in values1) {
        streamController1.add(
          DsDataPoint<bool>(
            type: DsDataType.bool,
            name: DsPointName(fullPath:'s.s.s/sss'),
            value: value > 0,
            status: DsStatus.ok,
            timestamp: DateTime.now().toIso8601String(),
          ),
        );
      }
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 1));
        return count != 6;
      });
      expect(resultList, equals(values1));
    });
    ///
    test('2 stream handling', () async {
      final streamController1 = StreamController<DsDataPoint<bool>>();
      final streamController2 = StreamController<DsDataPoint<bool>>();
      final streamMearged = StreamMergedOr([
        streamController1.stream,
        streamController2.stream,
      ]);
      var count = 0;
      final resultList = <int>[];
      streamMearged.stream.listen((event) {
        // log(_debug, '2 streams: event: ', event);
        resultList.add(event.value ? 1 : 0);
        count++;
      });
      for (int index = 0; index < 6; index++) {
        streamController1.add(
          DsDataPoint<bool>(
            type: DsDataType.bool,
            name: DsPointName(fullPath:'s.s.s/sss1'),
            value: values1[index] > 0,
            status: DsStatus.ok,
            timestamp: DateTime.now().toIso8601String(),
          ),
        );
        streamController2.add(
          DsDataPoint<bool>(
            type: DsDataType.bool,
            name: DsPointName(fullPath:'s.s.s/sss2'),
            value: values2[index] > 0,
            status: DsStatus.ok,
            timestamp: DateTime.now().toIso8601String(),
          ),
        );
      }
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 1));
        return count != 12;
      });
      expect(resultList, equals(mustResult2));
    });
    ///
    test('3 stream handling', () async {
      final streamController1 = StreamController<DsDataPoint<bool>>();
      final streamController2 = StreamController<DsDataPoint<bool>>();
      final streamController3 = StreamController<DsDataPoint<bool>>();
      final streamMearged = StreamMergedOr([
        streamController1.stream,
        streamController2.stream,
        streamController3.stream,
      ]);
      var count = 0;
      final resultList = <int>[];
      streamMearged.stream.listen((event) {
        // log(_debug, '2 streams: event: ', event);
        resultList.add(event.value ? 1 : 0);
        count++;
      });
      for (int index = 0; index < 6; index++) {
        streamController1.add(
          DsDataPoint<bool>(
            type: DsDataType.bool,
            name: DsPointName(fullPath:'s.s.s/sss1'),
            value: values1[index] > 0,
            status: DsStatus.ok,
            timestamp: DateTime.now().toIso8601String(),
          ),
        );
        streamController2.add(
          DsDataPoint<bool>(
            type: DsDataType.bool,
            name: DsPointName(fullPath:'s.s.s/sss2'),
            value: values2[index] > 0,
            status: DsStatus.ok,
            timestamp: DateTime.now().toIso8601String(),
          ),
        );
        streamController3.add(
          DsDataPoint<bool>(
            type: DsDataType.bool,
            name: DsPointName(fullPath: 's.s.s/sss3'),
            value: values3[index] > 0,
            status: DsStatus.ok,
            timestamp: DateTime.now().toIso8601String(),
          ),
        );
      }
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 1));
        return count != 18;
      });
      expect(resultList, equals(mustResult3));
    });
  },);
}
