import 'dart:async';
import 'dart:convert';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/text_file.dart';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/result/result.dart';
import 'package:hmi_core/src/core/result/result_transform_extension.dart';
import 'package:hmi_core/src/core/result/result_boolean_operations_extension.dart';
///
/// Decode json string into [List<T>].
class JsonList<T> {
  static const _log = Log('JsonList ');
  final FutureOr<List<ResultF<String>>> _contents;
  const JsonList._(FutureOr<List<ResultF<String>>> contents)
      : _contents = contents;
  ///
  /// Creates empty [JsonList].
  const JsonList.empty() : this._(const [Ok('')]);
  ///
  /// Creates [JsonList] that parses itself from [text] with json.
  JsonList.fromString(String text)
      : this._(
          [Ok(text)],
        );
  ///
  /// Creates [JsonList] that parses itself from json stored in [textFile].
  JsonList.fromTextFile(TextFile textFile)
      : this._(
          textFile.content.then((content) => [content]),
        );
  ///
  /// Creates [JsonList] that parses itself from json stored in [textFiles].
  JsonList.fromTextFiles(List<TextFile> textFiles)
      : this._(Future.wait(
          textFiles.map((textFile) => textFile.content),
        ));
  ///
  /// Decodes json and returns [Ok] with decoded [List<T>]
  /// if successful, and [Err] otherwise.
  Future<ResultF<List<T>>> get decoded async {
    final contentsResults = await _contents;
    final contentsResult = contentsResults.fold<ResultF<List<String>>>(
      Ok(List.from([])),
      (contentsResult, contentResult) => contentsResult.andThen(
        (contents) => contentResult.andThen(
          (content) => Ok(contents..add(content)),
        ),
      ),
    );
    return contentsResult
        .andThen(
          (contents) => contents.fold<ResultF<List<T>>>(
            Ok(List.from([])),
            (listResult, content) => listResult.andThen((list) {
              try {
                final decodedJson = const JsonCodec().decode(content) as List<dynamic>;
                return Ok(list..addAll(decodedJson.cast<T>()));
              } catch (error, _) {
                return Err(Failure('$runtimeType.get | $error'));
              }
            }),
          ),
        )
        .inspectErr(
          (error) => _log.warning(
            'Failed to parse list from json, ${error.message}',
          ),
        );
  }
}
