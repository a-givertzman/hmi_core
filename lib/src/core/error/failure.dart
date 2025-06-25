///
/// Ganeral Failures
/// - `Failure('Me.area | Error message')` - error happens locally
/// - `Failure.pass('Me.area |', error)` - error in some dependency returned from Me.area
/// - `Failure.pass('Me.area | message', error)` - error in some dependency returned from Me.area with additional message
class Failure<T> {
  // static const _log = Log('Failure');
  final T message;
  final dynamic _child;
  ///
  /// Ganeral Failures
  Failure(this.message) : _child = null;
  ///
  /// Ganeral Failures passing incoming error with message
  Failure.pass(this.message, dynamic err) : _child = err;
  ///
  /// Converts all children errors into single string
  String _join(int depth) {
    if (_child != null) {
      if (_child is Failure) {
        final tab = List.filled(depth, '\t').join();
        return '$message \n$tab${_child?._join(depth + 1)}';
      }
      return '$message \n\t$_child';
    }
    return '';
  }
  //
  @override
  String toString() {
    return '$message${_join(0)}';
  }
}
