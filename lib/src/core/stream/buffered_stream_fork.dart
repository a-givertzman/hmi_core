import 'dart:async';

/// Forks input stream on a given number of output streams.
/// Each output stream buffers incoming events before any subscribtion occurs on it.
class BufferedStreamFork<T> {
  late final List<StreamController<T>> _controllers;
  late final StreamSubscription<T> _subscription;
  int _listenersCount;
  /// 
  /// Forks input [stream] on [listenersCount] of output streams.
  /// Each output stream buffers incoming events before any subscribtion occurs on it.
  BufferedStreamFork({
    required Stream<T> stream, 
    int listenersCount = 1,
  }) : _listenersCount = listenersCount {
    _controllers = List.generate(
      listenersCount, 
      (_) => StreamController<T>(
        onCancel: () async {
          if(--_listenersCount == 0) {
            await _subscription.cancel();
          }
        },
      ),
      growable: false,
    );
    _subscription = stream.listen(
      (event) {
        for (final controller in _controllers) {
          controller.add(event);
        }
      },
      onDone: () {
        for (final controller in _controllers) {
          controller.close();
        }
      },
      onError: (error, stackTrace) {
        for (final controller in _controllers) {
          controller.addError(error, stackTrace);
        }
      },
    );
  }
  ///
  /// Returns one of the forks of incoming stream.
  Stream<T> stream(int index) => _controllers[index].stream;
}