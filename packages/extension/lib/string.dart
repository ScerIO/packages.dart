/// Returns string with capitalized first letter
///
/// Example:
/// ```dart
/// assert(capitalizeFirstLetter('test), 'Test');
/// ```
String capitalizeFirstLetter(String string) => (string?.isNotEmpty ?? false)
    ? '${string[0].toUpperCase()}${string.substring(1)}'
    : string;
