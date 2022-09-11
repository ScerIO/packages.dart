extension IterableExtension<T> on Iterable<T> {
  /// Split one large list to limited sub lists
  /// ```dart
  /// [1, 2, 3, 4, 5, 6, 7, 8, 9].chunks(2)
  /// // => [[1, 2], [3, 4], [5, 6], [7, 8], [9]]
  /// ```
  Iterable<List<T>> chunks(int chunkSize) sync* {
    final len = this.length;

    for (int i = 0; i < len; i += chunkSize) {
      final start = i > len ? i - len : i;
      yield skip(start).take(chunkSize).toList();
    }
  }
}

extension ListExtension<T> on List<T> {
  /// Split one large list to limited sub lists
  /// ```dart
  /// [1, 2, 3, 4, 5, 6, 7, 8, 9].chunks(2)
  /// // => [[1, 2], [3, 4], [5, 6], [7, 8], [9]]
  /// ```
  List<List<T>> chunks(int chunkSize) {
    final chunks = <List<T>>[];
    final len = this.length;
    for (int i = 0; i < len; i += chunkSize) {
      final size = i + chunkSize;
      chunks.add(this.sublist(i, size > len ? len : size));
    }
    return chunks;
  }
}
