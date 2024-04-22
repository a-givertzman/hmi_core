import 'dart:async';
import 'dart:convert';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/result_new/result.dart';
import 'package:hmi_core/src/core/text_file.dart';
///
class JsonMap<T> {
  static const _log = Log('JsonMap');
  final FutureOr<ResultF<String>> _content;
  const JsonMap._(FutureOr<ResultF<String>> content) : _content = content;
  JsonMap.fromString(String content) : this._(Ok(content));
  JsonMap.fromTextFile(TextFile textFile) : this._(textFile.content);
  ///
  Future<ResultF<Map<String, T>>> get decoded async {
    const failureMessage = 'Failed to parse json map from file.';
    switch(await _content) {
      case Ok(:final value):
        try {
          final decodedJson = const JsonCodec().decode(value) as Map<String,dynamic>;
          return Ok(
            decodedJson.cast<String,T>(),
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