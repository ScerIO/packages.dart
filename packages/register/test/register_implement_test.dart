import 'dart:convert';

import 'package:register/register.dart';
import 'package:test/test.dart';

void main() {
  test('id methods on NoOpNoOpRegister', () {
    final String s = 'thisIsATest';
    final NoOpRegister noOpId = NoOpRegister(s);

    expect(noOpId.snake, s);
    expect(noOpId.emacs, s);
    expect(noOpId.camel, s);
    expect(noOpId.capCamel, s);
    expect(noOpId.capSnake, s);
    expect(noOpId.shout, s);
    expect(noOpId.title, s);
    expect(noOpId.squish, s);
    expect(noOpId.abbrev, s);
    expect(noOpId.sentence, s);
    expect(noOpId.capSnake, s);
    expect(noOpId.toString(), s);
  });
}

/// Supports the same interface as Register but all transformations
/// like [camel], [snake],
/// ... resolve to no-ops.
///
/// This provides the ability to circumvent hard *Register*
/// casing rules in certain circumstances.
class NoOpRegister implements Register {
  NoOpRegister(id)
      : _id = id,
        _words = id.split('_');

  /// String containing the lower case words separated by '_'
  @override
  String get id => _id;

  /// Words comprising the id
  @override
  List<String> get words => _words;

  /// Return [id]
  @override
  String get snake => _id;

  /// Return [id]
  @override
  String get emacs => _id;

  /// Return [id]
  @override
  String get camel => _id;

  /// Return [id]
  @override
  String get capCamel => _id;

  /// Return [id]
  @override
  String get capSnake => _id;

  /// Return [id]
  @override
  String get shout => _id;

  /// Return [id]
  @override
  String get title => _id;

  /// Return [id]
  @override
  String get squish => _id;

  /// Return [id]
  @override
  String get abbrev => _id;

  /// Return [id]
  @override
  String get sentence => _id;

  /// Return [id]
  @override
  String toString() => _id;

  /// Returns a negative number if [id] is before [other], a postivie number
  /// if [id] is after other and zero if they are the same
  @override
  int compareTo(Register other) => id.compareTo(other.id);

  /// Return [Register] as json string
  @override
  String toJson() => json.encode({'id': _id});

  final String _id;
  final List<String> _words;
}
