/// Utilities for formatting numbers.
extension NumExtension<T extends num> on T {
  /// Transforms `this` into a `String` and pads it on the left if it is shorter
  /// than the given [width].
  String padLeft(int width, [String padding = '0']) =>
      toString().padLeft(width, padding);

  /// Transforms `this` into a `String` and pads it on the right if it is shorter
  /// than the given [width].
  String padRight(int width, [String padding = '0']) =>
      toString().padRight(width, padding);

  /// Returns `true` if `this` is between the given [min] (inclusive) and [max] (exclusive).
  bool between(num min, num max) {
    assert(min <= max,
        'Invalid bounds: $min and $max, min cannot be greater than max');
    return min <= this && this < max;
  }

  /// Returns `true` if this number is outside the given range of [min] (exclusive) and
  /// [max] (exclusive).
  bool outside(num min, num max) {
    assert(min <= max,
        'Invalid bounds: $min and $max, min cannot be greater than max');
    return this < min || this > max;
  }
}
