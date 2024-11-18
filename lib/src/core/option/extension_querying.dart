import 'package:hmi_core/hmi_core_option.dart';
///
/// Querying the contained values
extension Querying<V> on Option<V> {
  ///
  /// Returns `true` if the option is [Some], and `false` otherwise.
  ///
  /// ### Examples
  /// ```dart
  /// final Option<int> x = Some(-3);
  /// x.isSome(); // true
  ///
  /// final Option<int> y = None();
  /// y.isSome(); // false
  /// ```
  bool isSome() {
    return switch (this) {
      Some() => true,
      None() => false,
    };
  }
  ///
  /// Returns `true` if the option is [None], and `false` otherwise.
  ///
  /// ### Examples
  /// ```dart
  /// final Option<int> x = Some(-3);
  /// x.isNone(); // false
  ///
  /// final Option<int> y = None();
  /// y.isNone(); // true
  /// ```
  bool isNone() {
    return switch (this) {
      Some() => false,
      None() => true,
    };
  }
}
