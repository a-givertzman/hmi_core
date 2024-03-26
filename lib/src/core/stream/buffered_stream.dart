import 'dart:async';
import 'package:hmi_core/hmi_core.dart';

///
class BufferedStream<T> {
  final _log = Log('${BufferedStream<T>}');
  final StreamController<T> _controller;
  late final StreamSubscription<T> _subscription;
  final T? _initalValue;
  T? _lastValue;
  bool _isUpdated = false;
  ///
  BufferedStream(
    Stream<T> stream, {
    T? initValue,
  }) :
    _controller = StreamController<T>(),
    _lastValue = initValue,
    _initalValue = initValue
  {
    _subscription = stream.listen(
      (event) {
        _log.debug('[.stream.listen] event: $event');
        _lastValue = event;
        if (!_isUpdated) _isUpdated = true;
        _controller.add(event);
      },
      onError: (error, stackTrace) {
        _controller.addError(error, stackTrace);
      },
    );
    _controller.onCancel =  () {
      _log.debug('[._controller.onCancel] canceleing subscription...');
      return _subscription.cancel().then((value) {
        _log.debug('[._controller.onCancel] subscription canceled.');
      });
    };
  }
  ///
  Stream<T> get stream => _controller.stream;
  ///
  T? get value => _lastValue;
  ///
  T? get initialValue => _initalValue;
  ///
  bool get isUpdated => _isUpdated;
  ///
  Future<void> dispose() {
    return _subscription.cancel();
  }
}
