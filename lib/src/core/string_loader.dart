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
  @override
  Future<String> load() => File(_filePath).readAsString();
}
///
class _AssetStringLoader implements StringLoader {
  final String _assetPath;
  const _AssetStringLoader(this._assetPath);
  @override
  Future<String> load() => rootBundle.loadString(_assetPath);
}