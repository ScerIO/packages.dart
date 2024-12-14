class FormatResolver<T> {
  final String symbol;
  final T Function(String input) transform;

  const FormatResolver({
    required this.symbol,
    required this.transform,
  });
}

class PatternFormatter<T> {
  PatternFormatter(this._resolvers);

  final List<FormatResolver<T>> _resolvers;

  late final List<RegExp> _matchers = () {
    var include = '';
    var exclude = '';
    for (final resolver in _resolvers) {
      final symbol = RegExp.escape(resolver.symbol);
      include += '$symbol+|';
      exclude += symbol;
    }
    // Remove the trailing '|'
    include = include.substring(0, include.length - 1);

    return [
      // Quoted String - anything between single quotes, with escaping single quotes by doubling them.
      // For example, in the pattern 'hh 'o''clock'' it will match 'o''clock'.
      RegExp('^\'(?:[^\']|\'\')*\''),
      // Fields - any sequence of one or more of the same field characters.
      // For example, in 'hh:mm:ss' it will match hh, mm, and ss.
      // But in 'hms' it would match each letter individually.
      RegExp('^(?:$include)'),
      // Everything else - a sequence that is not quotes or field characters.
      // For example, in 'hh:mm:ss' it will match the colons.
      RegExp('^[^\'$exclude]+'),
    ];
  }();

  T format(String pattern) {
    // Parse the pattern string using the matchers
    var remaining = pattern;
    final results = <T>[];

    while (remaining.isNotEmpty) {
      Match? foundMatch;
      RegExp? usedMatcher;

      for (final matcher in _matchers) {
        final match = matcher.firstMatch(remaining);
        if (match != null) {
          foundMatch = match;
          usedMatcher = matcher;
          break;
        }
      }

      if (foundMatch == null || usedMatcher == null) {
        // No matches - possibly the remainder of the string cannot be processed.
        // Decide what to do: either throw an error or stop processing.
        break;
      }

      final fragment = foundMatch.group(0)!;
      final fragmentResult = formatFragment(fragment);
      results.add(fragmentResult);

      remaining = remaining.substring(foundMatch.end);
    }

    // Assuming T is for example String, and we want to join them.
    // If T is another type, adapt the logic for how to combine.
    if (T == String) {
      return results.join() as T;
    } else {
      // If it’s unclear how to combine, return the first element or throw an error.
      // Depends on the required logic.
      if (results.isEmpty) {
        throw StateError('No matches found for pattern: $pattern');
      }
      return results.first;
    }
  }

  T formatFragment(String patternFragment) {
    // Find the first matcher that matched
    for (final matcher in _matchers) {
      final match = matcher.firstMatch(patternFragment);
      if (match != null) {
        final matchedString = match.group(0)!;

        // It is assumed that the resolver symbol is a single character,
        // and matchedString consists of repeated occurrences of that symbol.
        final symbolChar = matchedString[0];

        final resolver = _resolvers.firstWhere(
          (r) => r.symbol == symbolChar,
          orElse: () {
            // If no resolver is found, decide what to do
            throw StateError('No resolver found for symbol: $symbolChar');
          },
        );

        return resolver.transform(matchedString);
      }
    }

    // If no matcher matched the fragment - an error.
    throw StateError('No matchers matched fragment: $patternFragment');
  }
}
