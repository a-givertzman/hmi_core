import 'dart:async';
import 'dart:convert';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/text_file.dart';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/result/result.dart';
import 'package:hmi_core/src/core/result/result_transform_extension.dart';
import 'package:hmi_core/src/core/result/result_boolean_operations_extension.dart';
///
/// Decode json string into [Map<String, T>].
class JsonMap<T> {
  static const _log = Log('JsonMap ');
  final FutureOr<List<ResultF<String>>> _contents;
  const JsonMap._(FutureOr<List<ResultF<String>>> contents)
      : _contents = contents;
  ///
  /// Creates empty [JsonMap].
  const JsonMap.empty() : this._(const [Ok('')]);
  ///
  /// Creates [JsonMap] that parses itself from [text] with json.
  JsonMap.fromString(String text)
      : this._(
          [Ok(text)],
        );
  ///
  /// Creates [JsonMap] that parses itself from json stored in [textFile].
  JsonMap.fromTextFile(TextFile textFile)
      : this._(
          textFile.content.then((content) => [content]),
        );
  ///
  /// Creates [JsonMap] that parses itself from json stored in [textFiles].
  JsonMap.fromTextFiles(List<TextFile> textFiles)
      : this._(Future.wait(
          textFiles.map((textFile) => textFile.content),
        ));
  ///
  /// Decodes json and returns [Ok] with decoded [Map<String, T>]
  /// if successful, and [Err] otherwise.
  Future<ResultF<Map<String, T>>> get decoded async {
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
          (contents) => contents.fold<ResultF<Map<String, T>>>(
            Ok(Map.from({})),
            (mapResult, content) => mapResult.andThen((map) {
              try {
                final decodedJson = const JsonCodec().decode(content) as Map<String, dynamic>;
                return Ok(map..addAll(decodedJson.cast<String, T>()));
              } catch (error, _) {
                return Err(Failure('$runtimeType.get | $error'));
              }
            }),
          ),
        )
        .inspectErr(
          (error) => _log.warning(
            'Failed to parse map from json, ${error.message}',
          ),
        );
  }
}
