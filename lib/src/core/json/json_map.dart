import 'dart:async';
import 'dart:convert';

import 'package:hmi_core/src/core/text_file.dart';
///
class JsonMap<T> {
  final FutureOr<String> _content;
  const JsonMap(String content) : _content = content;
  JsonMap.fromTextFile(TextFile textFile) : _content = textFile.content;
  Future<Map<String, T>> get decoded async {
    final map = const JsonCodec().decode(await _content) as Map<String, dynamic>;
    return map.cast<String, T>();
  }
}