import 'dart:async';

/// Forks input stream on a given number of output streams.
/// Each output stream buffers incoming events before subscribtion occurs on it.
class StreamFork<T> {
  late final List<StreamController<T>> _controllers;
  late final StreamSubscription<T> _subscription;
  int _listenersCount;
  /// 
  /// Forks input [stream] on [listenersCount] of output streams.
  /// Each output stream buffers incoming events before subscribtion occurs on it.
  StreamFork(
    Stream<T> stream, { 
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
///
/// Forks input stream on a single output stream.
/// Output stream buffers incoming events before subscribtion occurs on it.
class StreamForkSingle<T> extends StreamFork<T> {
  /// 
  /// Forks input [stream] on single output stream.
  /// output stream buffers incoming events before subscribtion occurs on it.
  StreamForkSingle(Stream<T> stream) : super(stream, listenersCount: 1);
}
///
/// Forks input stream on 2 output streams.
/// Each output stream buffers incoming events before subscribtion occurs on it.
class StreamForkDouble<T> extends StreamFork<T> {
  /// 
  /// Forks input [stream] on 2 output streams.
  /// Each output stream buffers incoming events before subscribtion occurs on it.
  StreamForkDouble(Stream<T> stream) : super(stream, listenersCount: 2);
}
///
/// Forks input stream on 3 output streams.
/// Each output stream buffers incoming events before subscribtion occurs on it.
class StreamForkTriple<T> extends StreamFork<T> {
  /// 
  /// Forks input [stream] on 3 output streams.
  /// Each output stream buffers incoming events before subscribtion occurs on it.
  StreamForkTriple(Stream<T> stream) : super(stream, listenersCount: 3);
}
