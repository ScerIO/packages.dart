/// Serialize map to query params string
String serializeQueryParameters(Map<String, dynamic> map) => map.entries.fold(
      '',
      (String acc, next) =>
          '$acc${acc.isEmpty ? '?' : '&'}${next.key.trim()}=${next.value}',
    );
