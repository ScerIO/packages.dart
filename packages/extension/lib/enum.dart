/// Throws if enum value not found
class EnumValueNotFoundException implements Exception {}

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
  if (values == null || key == null) throw Exception('Invalide params');

  for (T item in values) {
    // Remove Enum name from enum item
    final String itemName = item.toString().replaceFirst(RegExp(r'.+(\.)'), '');

    if (itemName.toLowerCase() == key.toLowerCase()) {
      return item;
    }
  }

  throw EnumValueNotFoundException();
}
