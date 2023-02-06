import 'dart:io';
import 'package:flutter/services.dart';
///
abstract class StringLoader {
  const factory StringLoader.fromFile(String filePath) = _FileStringLoader;
  const factory StringLoader.fromAsset(String assetPath) = _AssetStringLoader;
  Future<String> load();
}
///
class _FileStringLoader implements StringLoader {
  final String _filePath;
  const _FileStringLoader(this._filePath);
  // TODO to be implemented
  @override
  Future<String> load() => Future.value('{}');
  /// Do not use! It is stub!
  Future<String> loadImplementation() => File(_filePath).readAsString();
}
///
class _AssetStringLoader implements StringLoader {
  final String _assetPath;
  const _AssetStringLoader(this._assetPath);
  // TODO to be implemented
  @override
  Future<String> load() => Future.value('{}');
  /// Do not use! It is stub!
  Future<String> loadImplementation() => rootBundle.loadString(_assetPath);
}