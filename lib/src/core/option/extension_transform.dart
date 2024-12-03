import 'package:hmi_core/hmi_core_option.dart';
import 'package:hmi_core/hmi_core_result.dart';

///
/// Transforming contained values
extension OptionTransform<V, E> on Option<V> {
  ///
  /// Transforms the `Option<T>` into a [Result<T, E>],
  /// mapping [Some(v)] to [Ok(v)] and [None] to [Err(err)].
  ///
  /// Arguments passed to `ok_or` are eagerly evaluated; if you are passing the
  /// result of a function call, it is recommended to use [`ok_or_else`], which is
  /// lazily evaluated.
  ///
  /// [`Ok(v)`]: Ok
  /// [`Err(err)`]: Err
  /// [`Some(v)`]: Some
  /// [`ok_or_else`]: Option::ok_or_else
  ///
  /// # Examples
  ///
  /// ```
  /// let x = Some("foo");
  /// assert_eq!(x.ok_or(0), Ok("foo"));
  ///
  /// let x: Option<&str> = None;
  /// assert_eq!(x.ok_or(0), Err(0));
  /// ```
  Result<V, E> okOr(E err) {
      return switch (this) {
          Some(:final value) => Ok(value),
          None() => Err(err),
      };
  }
}
