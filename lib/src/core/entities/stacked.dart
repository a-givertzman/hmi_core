/// A Stack is a first-in-first-out (FIFO) data structure. 
/// If you make a stack of books, the first book you put down 
/// will be covered by any other books that you stack on top of it. 
/// And you can't get that book back until you remove 
/// all of the other books on top of it.
class Stacked<E> {
  final _list = <E>[];
  final int? _length;
  ///
  /// if [length] is not null and grater then 0, then [Stacked]
  /// will stores count of objects not more then [length]
  /// if additional object pushed, the last one will be deleted autonaticaly 
  Stacked({int? length}) : _length = length;
  /// 
  /// add a value to the top of the stack
  void push(E value) {
    _list.insert(0, value);
    final length = _length;
    if (length != null) {
      if (_list.length > length) {
        _list.removeLast();
      }
    }
  }
  ///
  /// removes and returns a value from the top of the stack
  E pop() => _list.removeAt(0);
  ///
  /// get the value of the top element in the stack without actually removing it
  E get peek => _list.first;
  ///
  bool get isEmpty => _list.isEmpty;
  ///
  bool get isNotEmpty => _list.isNotEmpty;
  ///
  void clear() {
    _list.clear();
  }
  ///
  List<E> toList() {
    return _list;
  }
  //
  @override
  String toString() => _list.toString();
}
