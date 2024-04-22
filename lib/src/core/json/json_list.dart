import 'dart:async';
import 'dart:convert';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/result_new/result.dart';
import 'package:hmi_core/src/core/text_file.dart';
///
class JsonList<T> {
  static const _log = Log('JsonList');
  final FutureOr<ResultF<String>> _content;
  const JsonList._(FutureOr<ResultF<String>> content) : _content = content;
  JsonList.fromString(String content) : this._(Ok(content));
  JsonList.fromTextFile(TextFile textFile) : this._(textFile.content);
  ///
  Future<ResultF<List<T>>> get decoded async {
    const failureMessage = 'Failed to parse json list from file.';
    switch(await _content) {
      case Ok(:final value):
        try {
          final decodedJson = const JsonCodec().decode(value) as List<dynamic>;
          return Ok(
            decodedJson.cast<T>(),
          );
        } catch(error) {
          _log.warning(failureMessage);
          return Err(
            Failure(
              message: error.toString(),
              stackTrace: StackTrace.current,
            ),
          );
        }
      case Err(:final error):
        _log.warning(failureMessage);
        return Err(error);
    }
  }
}