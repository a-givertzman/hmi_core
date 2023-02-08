import 'dart:async';
import 'dart:convert';

import 'package:hmi_core/src/core/text_file.dart';
///
class JsonList<T> {
  final FutureOr<String> _content;
  const JsonList(String content) : _content = content;
  JsonList.fromTextFile(TextFile textFile) : _content = textFile.content;
  Future<List<T>> get decoded async {
    final map = const JsonCodec().decode(await _content) as List<dynamic>;
    return map.cast<T>();
  }
}