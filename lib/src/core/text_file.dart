import 'dart:io';
import 'package:flutter/services.dart';
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
  Future<String> get content;
  /// 
  /// Rewrites the entire file with provided `text`.
  Future<void> write(String text);
}
///
class _PathTextFile implements TextFile {
  final String _filePath;
  const _PathTextFile(this._filePath);
  //
  @override
  Future<String> get content => File(_filePath).readAsString();
  //
  @override
  Future<void> write(String text) => File(_filePath).writeAsString(text, flush: true);
}
///
class _AssetTextFile implements TextFile {
  final String _assetPath;
  const _AssetTextFile(this._assetPath);
  //
  @override
  Future<String> get content => rootBundle.loadString(_assetPath);
  //
  @override
  Future<void> write(String text) {
    throw UnimplementedError('Unable to write to asset file.');
  }
}