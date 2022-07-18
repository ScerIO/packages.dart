import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:quiver/core.dart';

/// Given an id (all lower case string of words separated by '_')...
class Register implements Comparable<Register> {
  /// `id` must be a string in snake case (e.g. `how_now_brown_cow`)
  Register(String id)
      : _id = id,
        _words = id.split('_') {
    if (null != _hasUpperRe.firstMatch(id)) {
      throw ArgumentError('Register must be lower case $id');
    }
    if (null == _validSnakeRe.firstMatch(id)) {
      throw ArgumentError('Register has invalid characters $id');
    }
  }

  /// Create an [Register] from string in camels case
  Register.fromCamels(String camelRegister)
      : this(splitCamelHumps(camelRegister));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Register &&
          _id == other._id &&
          const ListEquality().equals(_words, other._words));

  @override
  int get hashCode => hash2(_id, const ListEquality<String>().hash(_words));

  /// String containing the lower case words separated by '_'
  String get id => _id;

  /// Words comprising the id
  List<String> get words => _words;

  // custom <class Register>

  /// Create an [Register] from string in camels case
  static Register idFromCamels(String camelRegister) =>
      Register.fromCamels(camelRegister);

  /// Return true if [text] is camel case
  static bool isCamel(String text) => _camelRe.firstMatch(text) != null;

  /// Return true if [text] is cap camel case
  static bool isCapCamel(String text) => _capCamelRe.firstMatch(text) != null;

  /// Return true if [text] is snake case
  static bool isSnake(String text) => _snakeRe.firstMatch(text) != null;

  /// Return true if [text] is cap snake case
  static bool isCapSnake(String text) => _capSnakeRe.firstMatch(text) != null;

  /// Return true if [text] is all caps
  static bool isAllCap(String text) => _allCapRe.firstMatch(text) != null;

  static final RegExp _capCamelRe = RegExp(r'^[A-Z][A-Za-z\d]*$');
  static final RegExp _camelRe = RegExp(r'^(?:[A-Za-z]+[a-z\d]*)+$');
  static final RegExp _snakeRe = RegExp(r'^[a-z]+[a-z\d]*(?:_[a-z\d]+)*$');
  static final RegExp _capSnakeRe = RegExp(r'^[A-Z][a-z\d]*(?:_[a-z\d]+)*$');
  static final RegExp _capWordDelimiterRe = RegExp('[A-Z]');
  static final RegExp _allCapRe = RegExp(r'^[A-Z][A-Z_\d]+$');
  static final RegExp _leadingTrailingUnderbarRe = RegExp(r'(?:^_)|(?:_$)');

  /// Split [text] camel text into words
  static String splitCamelHumps(String text) {
    if (text.contains('_')) {
      throw ArgumentError('Camels can not have underscore: $text');
    }

    return text
        .splitMapJoin(_capWordDelimiterRe,
            onMatch: (Match match) => match.group(0)?.toLowerCase() ?? '',
            onNonMatch: (String nonMatch) => nonMatch + '_')
        .replaceAll(_leadingTrailingUnderbarRe, '');
  }

  static final RegExp _hasUpperRe = RegExp(r'[A-Z]');
  static final RegExp _validSnakeRe = RegExp(r'^[a-z][a-z\d_]*$');

  /// Capitalize the string (i.e. make first
  /// character capital, leaving rest alone)
  static String capitalize(String s) =>
      '${s[0].toUpperCase()}${s.substring(1)}';

  /// Unapitalize the string (i.e. make first
  /// character lower, leaving rest alone)
  static String uncapitalize(String s) =>
      '${s[0].toLowerCase()}${s.substring(1)}';

  /// Return this id as snake case - (i.e. the case passed in for construction)
  /// (e.g. `how_now_brown_cow`)
  String get snake => _id;

  /// Return this id as hyphenated words (e.g. `how_now_brown_cow` =>
  /// `how-now-brown-cow`)
  String get emacs => _words.join('-');

  /// Return as camel case, first character lower and each word capitalized
  /// (e.g. `how_now_brown_cow` => `howNowBrownCow`)
  String get camel => uncapitalize(_words.map(capitalize).join(''));

  /// Return as cap camel case, same as camel with first word capitalized
  /// (e.g. `how_now_brown_cow` => `HowNowBrownCow`)
  String get capCamel => _words.map(capitalize).join('');

  /// Return snake case capitalized (e.g.
  /// `how_now_brown_cow` => 'How_now_brown_cow`)
  String get capSnake => capitalize(snake);

  /// Return all caps with underscore separator (e.g. `how_now_brown_cow` =>
  /// `HOW_NOW_BROWN_COW`)
  String get shout => _words.map((String w) => w.toUpperCase()).join('_');

  /// Return each word capitalized with space `' '` separator
  /// (e.g. `how_now_brown_cow` => `How Now Brown Cow`)
  String get title => _words.map(capitalize).join(' ');

  /// Return words squished together with no separator (e.g. `how_now_brown_cow`
  /// => `hownowbrowncow`)
  String get squish => _words.join('');

  /// Return first letter of each word joined together (e.g. `how_now_brown_cow`
  /// => `hnbc`)
  String get abbrev => _words.map((String w) => w[0]).join();

  /// Return the words joined with spaces like a sentence only (without first
  /// word capitalized)
  String get sentence => _words.join(' ');

  /// Return id as the plural of the argument
  /// (`Register('dog')` => `Register('dogs')`)
  static Register pluralize(Register id, [String suffix = 's']) =>
      Register(id._id + suffix);

  /// Returns the id with default casing of [camel]
  @override
  String toString() => camel;

  /// Return [Register] as json string
  String toJson() => json.encode({'id': _id});

  /// Returns a negative number if [id] is before [other], a postivie number
  /// if [id] is after other and zero if they are the same
  @override
  int compareTo(Register other) => id.compareTo(other.id);

  static Register fromJson(String jsonString) {
    final Map jsonMap = json.decode(jsonString);
    return fromJsonMap(jsonMap);
  }

  /// Return constructed [Register] from json map representing an [Register]
  static Register fromJsonMap(Map jsonMap) => Register(jsonMap['id']);

  // end <class Register>

  final String _id;
  final List<String> _words;
}

/// Register-like object with special overrides for [snake], [emacs], [camel],
///  [capCamel] and [capSnake] which end in *unserscore*
/// (or *hyphen* for emacs). The purpose is to support special
///  *terms* that conflict with keywords in target languages (e.g.
/// String -> String_)
class RegisterTrailingUnderscore extends Register {
  RegisterTrailingUnderscore(id) : super(id);

  @override
  String get snake => super.snake + '_';

  @override
  String get emacs => super.emacs + '-';

  @override
  String get camel => super.camel + '_';

  @override
  String get capCamel => super.capCamel + '_';

  @override
  String get capSnake => Register.capitalize(super.snake) + '_';
}

/// Create an [Register] from text
///
/// Provides a heuristic to turn a string into an [Register]
/// where individual words are identified.
///
/// For example, each of the following print *[ 'this', 'is', 'a', 'test' ]*
///
///     print(idFromString('thisIsATest').words);
///     print(idFromString('this_is_a_test').words);
///     print(idFromString('ThisIsATest').words);
///     print(idFromString('This_is_a_test').words);
///     print(idFromString('THIS_IS_A_TEST').words);
///
Register idFromString(String text) => Register.isSnake(text)
    ? Register(text)
    : (Register.isAllCap(text)
        ? idFromString(text.toLowerCase())
        : (Register.isCamel(text)
            ? Register.fromCamels(text)
            : (Register.isCapSnake(text)
                ? Register(text.toLowerCase())
                : throw ArgumentError('$text is neither snake or camel'))));

/// Creates an [Register] when passed [String], returns the Register when
/// passed an Register
Register getOrCreateRegister(Object id) => id is Register
    ? id
    : id is String
        ? idFromString(id)
        : throw Exception('*getOrCreateRegister(id)* requires an [Register] '
            'or [String], given ${id.runtimeType}');

final RegExp _whiteSpaceRe = RegExp(r'\s+');

/// Create an [Register] from a sentence like string of white-space
/// delimited words
///
/// For example, each of the following print *[ 'this', 'is', 'a', 'test' ]*
///
///     print(idFromWords('this is a test').words);
///     print(idFromWords('This is a test').words);
///     print(idFromWords('  THIS IS A TEST  ').words);
///
Register idFromWords(String words) =>
    idFromString(words.trim().replaceAll(_whiteSpaceRe, '_'));

final RegExp _capSubstring = RegExp(r'([A-Z]+)([A-Z]|$)');

///
/// Given a camel case word [s] with all cap abbreviations embedded, converts
/// the abbreviations to camel.
///
/// e.g.  capSubstringToCamel('CIASpy') -> 'CiaSpy'
///
String capSubstringToCamel(String s) => s.replaceAllMapped(_capSubstring,
    (Match m) => '${Register.capitalize(m[1]?.toLowerCase() ?? '')}${m[2]}');

/// Create a [RegisterTrailingUnderscore]
Register idTrailingUnderscore(Object id) => RegisterTrailingUnderscore(id);
