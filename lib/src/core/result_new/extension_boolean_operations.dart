import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Boolean operations on the values, eager and lazy
///
/// These methods treat the [Result] as a boolean value, where [Ok]
/// acts like `true` and [Err] acts like `false`. There are two
/// categories of these methods: ones that take a [Result] as input, and
/// ones that take a function as input (to be lazily evaluated).
///
/// The [and] and [or] methods take another [Result] as input, and
/// produce a [Result] as output. The [and] method can produce a
/// `Result<U, E>` value having a different inner type `U` than
/// `Result<V, E>`. The [or] method can produce a `Result<V, F>`
/// value having a different error type `F` than `Result<V, E>`.
///
/// | method  | self     | input     | output   |
/// |---------|----------|-----------|----------|
/// | `and` | `Err(e)` | (ignored) | `Err(e)` |
/// | `and` | `Ok(x)`  | `Err(d)`  | `Err(d)` |
/// | `and` | `Ok(x)`  | `Ok(y)`   | `Ok(y)`  |
/// | `or`  | `Err(e)` | `Err(d)`  | `Err(d)` |
/// | `or`  | `Err(e)` | `Ok(y)`   | `Ok(y)`  |
/// | `or`  | `Ok(x)`  | (ignored) | `Ok(x)`  |
///
/// The [andThen] and [orElse] methods take a function as input, and
/// only evaluate the function when they need to produce a new value. The
/// [andThen] method can produce a `Result<U, E>` value having a
/// different inner type `U` than `Result<V, E>`. The [orElse] method
/// can produce a `Result<V, F>` value having a different error type `F`
/// than `Result<V, E>`.
///
/// | method       | self     | function input | function result | output   |
/// |--------------|----------|----------------|-----------------|----------|
/// | `andThen` | `Err(e)` | (not provided) | (not evaluated) | `Err(e)` |
/// | `andThen` | `Ok(x)`  | `x`            | `Err(d)`        | `Err(d)` |
/// | `andThen` | `Ok(x)`  | `x`            | `Ok(y)`         | `Ok(y)`  |
/// | `orElse`  | `Err(e)` | `e`            | `Err(d)`        | `Err(d)` |
/// | `orElse`  | `Err(e)` | `e`            | `Ok(y)`         | `Ok(y)`  |
/// | `orElse`  | `Ok(x)`  | (not provided) | (not evaluated) | `Ok(x)`  |
extension BooleanOperations<V, E> on Result<V, E> {
  ///
  /// Returns [result] if the result is [Ok], otherwise returns the [Err] value of `this`.
  ///
  /// Arguments passed to [and] are eagerly evaluated; if you are passing the
  /// result of a function call, it is recommended to use [andThen], which is
  /// lazily evaluated.
  ///
  /// ### Examples
  ///
  /// ```
  /// final Result<int, String> x1 = Ok(2);
  /// final Result<String, String> y1 = Err("late error");
  /// x1.and(y1); // Err("late error")
  ///
  /// final Result<int, String> x2 = Err("early error");
  /// final Result<String, String> y2 = Ok("foo");
  /// x2.and(y2); // Err("early error")
  ///
  /// final Result<int, String> x3 = Err("not a 2");
  /// final Result<String, String> y3 = Err("late error");
  /// x3.and(y3); // Err("not a 2")
  ///
  /// final Result<int, String> x4 = Ok(2);
  /// final Result<String, String> y4 = Ok("different result type");
  /// x4.and(y4); // Ok("different result type")
  /// ```
  Result<U, E> and<U>(Result<U, E> result) {
    return switch (this) {
      Ok() => result,
      Err(:final error) => Err(error),
    };
  }
  ///
  /// Calls [op] if the result is [Ok], otherwise returns the [Err] value of `this`.
  ///
  /// This function can be used for control flow based on [Result] values.
  ///
  /// Often used to chain fallible operations that may return [Err].
  ///
  /// ### Examples
  ///
  /// ```dart
  /// Result<String, String> sqThenToString(int x) {
  ///   return x > -1000 && x < 1000 ? '${x * x}' : Err('Overflowed');
  /// }
  ///
  /// Ok(2).andThen(sqThenToString); // Ok("4")
  /// Ok(1000000).andThen(sqThenToString); // Err("Overflowed")
  /// Err("Not a number").andThen(sqThenToString); // Err("Not a number")
  /// ```
  Result<U, E> andThen<U>(Result<U, E> Function(V value) op) {
    return switch (this) {
      Ok(:final value) => op(value),
      Err(:final error) => Err(error),
    };
  }
  ///
  /// Returns [result] if the result is [Err], otherwise returns the [Ok] value of `this`.
  ///
  /// Arguments passed to [or] are eagerly evaluated; if you are passing the
  /// result of a function call, it is recommended to use [orElse], which is
  /// lazily evaluated.
  ///
  /// ### Examples
  ///
  /// ```dart
  /// final Result<int, String> x1 = Ok(2);
  /// final Result<int, String> y1 = Err("late error");
  /// x1.or(y1); // Ok(2)
  ///
  /// final Result<int, String> x2 = Err("early error");
  /// final Result<int, String> y2 = Ok(2);
  /// x2.or(y2); // Ok(2)
  ///
  /// final Result<int, String> x3 = Err("not a 2");
  /// final Result<int, String> y3 = Err("late error");
  /// x3.or(y3); // Err("late error")
  ///
  /// final Result<int, String> x4 = Ok(2);
  /// final Result<int, String> y4 = Ok(100);
  /// x4.or(y4); // Ok(2)
  /// ```
  Result<V, E> or(Result<V, E> result) {
    return switch (this) {
      Ok(:final value) => Ok(value),
      Err() => result,
    };
  }
  ///
  /// Calls [op] if the result is [Err], otherwise returns the [Ok] value of `this`.
  ///
  /// This function can be used for control flow based on [Result] values.
  ///
  /// ### Examples
  ///
  /// ```dart
  /// Result<int, int> sq(int x) => Ok(x * x);
  /// Result<int, int> err(int x) => Err(x);
  ///
  /// Ok(2).orElse(sq).orElse(sq); // Ok(2)
  /// Ok(2).orElse(err).orElse(sq); // Ok(2)
  /// Err(3).orElse(sq).orElse(err); // Ok(9)
  /// Err(3).orElse(err).orElse(err); // Err(3)
  /// ```
  Result<V, E> orElse(Result<V, E> Function(E error) f) {
    return switch (this) {
      Ok(:final value) => Ok(value),
      Err(:final error) => f(error),
    };
  }
}
