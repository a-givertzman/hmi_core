import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hmi_core/src/core/error/failure.dart';
import 'package:hmi_core/src/core/log/log.dart';
import 'package:hmi_core/src/core/result_new/result.dart';
/// The interface for reading and writing a text file.
abstract interface class TextFile {
  /// Text file from the file system.
  /// 
  /// `filePath` - file system valid relative or full path to the file.
  const factory TextFile.path(String filePath) = _PathTextFile;
  /// Text file from application asset bundle. 
  /// 
  /// `assetPath` - path to the file according to your `assets` section in `pubspec.yaml`.
  const factory TextFile.asset(String assetPath) = _AssetTextFile;
  ///
  /// Internal file contents as text. 
  /// 
  /// Returns [Ok] with text if file exists and [Err] with error otherwise.
  Future<ResultF<String>> get content;
  /// 
  /// Rewrites the entire file with provided `text`.
  Future<void> write(String text);
}
///
class _PathTextFile implements TextFile {
  static const _log = Log('_PathTextFile');
  final String _filePath;
  const _PathTextFile(this._filePath);
  //
  @override
  Future<ResultF<String>> get content async {
    final file = File(_filePath);
    switch(await file.exists()) {
      case true:
        return Ok(await file.readAsString());
      case false:
        _log.warning('Failed to read from file.');
        return Err(
          Failure(
            message: 'File $_filePath does not exist.', 
            stackTrace: StackTrace.current,
          ),
        );
    }
  }
  //
  @override
  Future<void> write(String text) => File(_filePath).writeAsString(text, flush: true);
}
///
class _AssetTextFile implements TextFile {
  static const _log = Log('_AssetTextFile');
  final String _assetPath;
  const _AssetTextFile(this._assetPath);
  //
  @override
  Future<ResultF<String>> get content {
    return rootBundle.loadString(_assetPath)
      .then<ResultF<String>>((value) => Ok(value))
      .catchError((error) {
        _log.warning('Failed to read from asset.');
        return Err<String, Failure>(
          Failure(
            message: error.toString(),
            stackTrace: StackTrace.current,
          ),
        );
      });
  }
  //
  @override
  Future<void> write(String text) {
    throw UnimplementedError('Unable to write to asset file.');
  }
}