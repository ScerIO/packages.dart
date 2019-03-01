/// Returns enum value by string
///
/// ```dart
/// enum Enum {
///   one,
///   two,
/// }
///
/// enumValueByString(Enum.values, 'one') == Enum.one
/// ```
T enumValueByString<T>(List<T> values, String key) {
  if (key == null) return null;

  for (T item in values) {
    // Remove Enum name from enum item
    final String itemName = item.toString().replaceFirst(RegExp(r'.+(\.)'), '');

    if (itemName.toLowerCase() == key.toLowerCase()) {
      return item;
    }
  }

  return null;
}
