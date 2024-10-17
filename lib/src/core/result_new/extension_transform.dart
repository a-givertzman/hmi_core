import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Transforming contained values
extension Transform<V, E> on Result<V, E> {
  ///
  /// Maps a `Result<V, E>` to `Result<U, E>` by applying a function to a
  /// contained [Ok] value, leaving an [Err] value untouched.
  ///
  /// This function can be used to compose the results of two functions.
  ///
  /// ### Examples
  ///
  /// Print the numbers on each line of a string multiplied by two.
  ///
  /// ```dart
  /// final line = "1\n2\n3\n4\n";
  ///
  /// Result<int, String> parse(String s) {
  ///   return switch (int.tryParse(s)) {
  ///     final int value => Ok(value),
  ///     null => Err('Cannot parse $s into an integer'),
  ///   };
  /// }
  ///
  /// for (final num in line.split('\n')) {
  ///   switch (parse(num).map((n) => n * 2)) {
  ///     case Ok(:final value):
  ///       print(value);
  ///     case Err(:final error):
  ///       print(error);
  ///   }
  /// }
  /// ```
  Result<U, E> map<U>(U Function(V value) op) {
    return switch (this) {
      Ok(:final V value) => Ok(op(value)),
      Err(:final E error) => Err(error),
    };
  }
  ///
  /// Maps a `Result<V, E>` to `U` by returning default value [d] (if the result is [Err]),
  /// or applying a function [f] to the contained value (if the result is [Ok]).
  ///
  /// Arguments passed to [mapOr] are eagerly evaluated; if you are passing
  /// the result of a function call, it is recommended to use [mapOrElse],
  /// which is lazily evaluated.
  ///
  /// ### Examples
  ///
  /// ```dart
  /// final Result<String, String> x = Ok("foo");
  /// x.mapOr(42, (v) => v.length); // 3
  ///
  /// final Result<String, String> y = Err("bar");
  /// y.mapOr(42, (v) => v.length); // 42
  /// ```
  U mapOr<U>(U d, U Function(V value) f) {
    return switch (this) {
      Ok(:final V value) => f(value),
      Err() => d,
    };
  }
  ///
  /// Maps a `Result<V, E>` to `U` by applying fallback function [d] to
  /// a contained [Err] value, or function [f] to a contained [Ok] value.
  ///
  /// This function can be used to unpack a successful result
  /// while handling an error.
  ///
  /// ### Examples
  ///
  /// ```dart
  /// final k = 21;
  ///
  /// final Result<String, String> x = Ok("foo");
  /// x.mapOrElse((e) => k * 2, (v) => v.length); // 3
  ///
  /// final Result<String, String> y = Err("bar");
  /// y.mapOrElse((e) => k * 2, (v) => v.length); // 42
  /// ```
  U mapOrElse<U>(U Function(E value) d, U Function(V value) f) {
    return switch (this) {
      Ok(:final V value) => f(value),
      Err(:final E error) => d(error),
    };
  }
  ///
  /// Maps a `Result<V, E>` to `Result<U, F>` by applying a function to a
  /// contained [Err] value, leaving an [Ok] value untouched.
  ///
  /// This function can be used to pass through a successful result while handling
  /// an error.
  ///
  /// ### Examples
  ///
  /// ```dart
  /// String stringify(int x) => "error code: $x";
  ///
  /// final Result<int, int> x = Ok(2);
  /// x.mapErr(stringify); // Ok(2)
  ///
  /// final Result<int, int> y = Err(13);
  /// y.mapErr(stringify); // Err("error code: 13")
  /// ```
  Result<V, F> mapErr<F>(F Function(E error) op) {
    return switch (this) {
      Ok(:final V value) => Ok(value),
      Err(:final E error) => Err(op(error)),
    };
  }
  ///
  /// Calls a function [f] with a reference to the contained value
  /// if the result is [Ok].
  ///
  /// Returns the original result.
  ///
  /// ### Examples
  ///
  /// ```dart
  /// Result<int, String> parse(String s) {
  ///   return switch (int.tryParse(s)) {
  ///     final int value => Ok(value),
  ///     null => Err('Cannot parse $s into an integer'),
  ///   };
  /// }
  ///
  /// final num x = parse("4")
  ///     .inspect((x) => print("original: $x"))
  ///     .map((x) => pow(x, 3))
  ///     .expect("failed to parse number");
  /// ```
  Result<V, E> inspect(Function(V value) f) {
    if (this case Ok(:final value)) {
      f(value);
    }
    return this;
  }
  ///
  /// Calls a function [f] with a reference to the contained value
  /// if the result is [Err].
  ///
  /// Returns the original result.
  ///
  /// ### Examples
  ///
  /// ```dart
  /// Result<int, String> parse(String s) {
  ///   return switch (int.tryParse(s)) {
  ///     final int value => Ok(value),
  ///     null => Err('Cannot parse $s into an integer'),
  ///   };
  /// }
  ///
  /// parse("not a number")
  ///    .inspectErr((e) => print("failed to parse: $e"))
  /// ```
  Result<V, E> inspectErr(Function(E error) f) {
    if (this case Err(:final error)) {
      f(error);
    }
    return this;
  }
}
