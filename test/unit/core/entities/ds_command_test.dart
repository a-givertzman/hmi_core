import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void _testIfThrows(Map<String,dynamic> map) {
  expect(
    () => DsCommand.fromJson(json.encode(map)), 
    throwsA(isA<Failure>()),
  );
}

DsCommand _getCommandWith({
  DsDataClass dsClass = DsDataClass.commonCmd,
  DsDataType type = DsDataType.bool,
  String path = 'path',
  String name = 'name',
  dynamic value=0,
  DsStatus status = DsStatus.ok,
  required DsTimeStamp timestamp,
}) {
  return DsCommand(
        dsClass: dsClass, 
        type: type,
        path: path,
        name: name,
        value: value,
        status: status,
        timestamp: timestamp,
  );
}

String _getStringifiedCommandWithValue(dynamic value, DsTimeStamp timestamp) {
  return json.encode({
    'class': 'commonCmd',
    'type': 'bool',
    'path': 'path',
    'name': 'name',
    'value': value,
    'status': 0,
    'timestamp': timestamp.toString(),
  });
}

void main() {
  group('DsCommand', () {
    group('fromJson()', () {
      group('with incorrect', () {
        test('empty map', () {
          _testIfThrows({});
        });
        test('not full map', () {
          _testIfThrows({
            'path': 'abc',
            'name': 'abc',
          });
        });
        test('class', () {
          _testIfThrows({
            'class': 0,
            'type': 'bool',
            'path': 'abc',
            'name': 'bdc',
            'value': 0,
            'status': 0,
            'timestamp': DateTime.now().toString(),
          });
        });
        test('type', () {
          _testIfThrows({
            'class': 'requestAll',
            'type': 0,
            'path': 'abc',
            'name': 'bdc',
            'value': 0,
            'status': 0,
            'timestamp': DateTime.now().toString(),
          });
        });
        test('status', () {
          _testIfThrows({
            'class': 'requestAll',
            'type': 'bool',
            'path': 'abc',
            'name': 'abc',
            'value': 0,
            'status':'abc',
            'timestamp': DateTime.now().toString(),
          });
        });
        test('timestamp', () {
          _testIfThrows({
            'class': 'requestAll',
            'type': 'bool',
            'path': 'abc',
            'name': 'bdc',
            'value': 0,
            'status': 0,
            'timestamp': 0,
          });
        });
      });
      group('with correct', () {
        test('string', () {

        });
      });
    });
    group('toJson()', () {
      final timestamp = DsTimeStamp.now();
      // int
      test('with int value', () {
        expect(
          _getCommandWith(value: 0, timestamp: timestamp).toJson(), 
          _getStringifiedCommandWithValue(0, timestamp),
        );
      });
      test('with double value', () {
        expect(
          _getCommandWith(value: 0.5, timestamp: timestamp).toJson(), 
          _getStringifiedCommandWithValue(0.5, timestamp),
        );
      });
      test('with string value', () {
        expect(
          _getCommandWith(value: 'test', timestamp: timestamp).toJson(), 
          _getStringifiedCommandWithValue('test', timestamp),
        );
      });
      test('with bool value', () {
        expect(
          _getCommandWith(value: true, timestamp: timestamp).toJson(), 
          _getStringifiedCommandWithValue(true, timestamp),
        );
      });      
    });
    group('operator == comparison', () {
      final timestamp = DsTimeStamp.now();
      test('between wrong types', () {
        expect(_getCommandWith(timestamp: timestamp) == 'command', false);
      });
      test('by class', () {
        expect(
          _getCommandWith(dsClass: DsDataClass.requestTime, timestamp: timestamp) 
          == 
          _getCommandWith(dsClass: DsDataClass.requestList, timestamp: timestamp),
          false,
        );
        expect(
          _getCommandWith(dsClass: DsDataClass.requestTime, timestamp: timestamp) 
          == 
          _getCommandWith(dsClass: DsDataClass.requestTime, timestamp: timestamp),
          true,
        );
      });
      test('by type', () {
        expect(
          _getCommandWith(type: DsDataType.bool, timestamp: timestamp) 
          == 
          _getCommandWith(type: DsDataType.dInt, timestamp: timestamp),
          false,
        );
        expect(
          _getCommandWith(type: DsDataType.real, timestamp: timestamp) 
          == 
          _getCommandWith(type: DsDataType.real, timestamp: timestamp),
          true,
        );
      });
      test('by path', () {
        expect(
          _getCommandWith(path: 'path1', timestamp: timestamp) 
          ==
          _getCommandWith(path: 'path2', timestamp: timestamp),
          false,
        );
        expect(
          _getCommandWith(path: 'path', timestamp: timestamp) 
          ==
          _getCommandWith(path: 'path', timestamp: timestamp),
          true,
        );
      });
      test('by name', () {
        expect(
          _getCommandWith(name: 'name1', timestamp: timestamp) 
          == 
          _getCommandWith(name: 'name2', timestamp: timestamp),
          false,
        );
        expect(
          _getCommandWith(name: 'name', timestamp: timestamp) 
          == 
          _getCommandWith(name: 'name', timestamp: timestamp),
          true,
        );
      });
      test('by value', () {
        expect(
          _getCommandWith(value: 10, timestamp: timestamp) 
          == 
          _getCommandWith(value: 20, timestamp: timestamp),
          false,
        );
        expect(
          _getCommandWith(value: 10, timestamp: timestamp) 
          == 
          _getCommandWith(value: 'test', timestamp: timestamp),
          false,
        );
        expect(
          _getCommandWith(value: 10, timestamp: timestamp) 
          == 
          _getCommandWith(value: 10, timestamp: timestamp),
          true,
        );
      });
      test('by status', () {
        expect(
          _getCommandWith(status: DsStatus.ok, timestamp: timestamp) 
          == 
          _getCommandWith(status: DsStatus.invalid, timestamp: timestamp),
          false,
        );
        expect(
          _getCommandWith(status: DsStatus.ok, timestamp: timestamp) 
          == 
          _getCommandWith(status: DsStatus.ok, timestamp: timestamp),
          true,
        );
      });
    });
  });
}