import 'package:hmi_core/hmi_core_failure.dart';
///
class DsPointName {
  final String _fullPath;
  final int _lastSeparatorIndex;
  ///
  DsPointName({required String fullPath}) : 
    _fullPath = fullPath,
    assert(DsPointName._validatePath(fullPath), 'Full path format validation is failed...'),
    _lastSeparatorIndex = _findLastMatchIndex(fullPath, '/');
  ///
  String get path => _fullPath.substring(0, _lastSeparatorIndex+1);
  ///
  String get name => _fullPath.substring(_lastSeparatorIndex+1);
  //
  @override
  String toString() => _fullPath;
  ///
  /// Finds index of last [symbol] appearance in [source] string.
  static int _findLastMatchIndex(String source, String symbol) {
    for(int i = source.length - 1; i >= 0; i--) {
      if(source[i] == symbol) {
        return i;
      }
    }
    throw Failure(
      message: 'Ошибка в методе $DsPointName._findLastSeparatorIndex: неверный формат пути: "$source"',
      stackTrace: StackTrace.current,
    );
  }
  ///
  static bool _validatePath(String source) {
    if (source[0] != '/') {
      throw Failure(
        message: 'Ошибка в методе $DsPointName._validatePath: неверный формат пути: "$source"\n\tДолжен начинаться с "/"',
        stackTrace: StackTrace.current,
      );
    }
    return true;
  }
  ///
  @override
  bool operator ==(Object other) =>
    other is DsPointName
    && _fullPath == '$other';
  ///
  @override
  int get hashCode => _fullPath.hashCode;
}