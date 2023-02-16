import 'dart:io';
import 'package:flutter/services.dart';
///
abstract class TextFile {
  ///
  const factory TextFile.path(String filePath) = _PathTextFile;
  ///
  const factory TextFile.asset(String assetPath) = _AssetTextFile;
  ///
  Future<String> get content;
}
///
class _PathTextFile implements TextFile {
  final String _filePath;
  const _PathTextFile(this._filePath);
  @override
  Future<String> get content => File(_filePath).readAsString();
}
///
class _AssetTextFile implements TextFile {
  final String _assetPath;
  const _AssetTextFile(this._assetPath);
  @override
  Future<String> get content => rootBundle.loadString(_assetPath);
}