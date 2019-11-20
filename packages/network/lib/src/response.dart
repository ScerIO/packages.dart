import 'dart:convert' show jsonDecode, utf8;
import 'dart:typed_data' show Uint8List;

import 'package:meta/meta.dart';
import 'package:network/src/request.dart';

class Response {
  /// Response status code
  final int statusCode;

  /// Response body bytes
  final Uint8List bytes;

  final Request request;

  /// Raw binary response
  Response({
    @required this.statusCode,
    @required this.bytes,
    @required this.request,
  });

  Object _decodedJson;

  /// Parses the body bytes and returns the resulting Json object.
  ///
  /// The optional [reviver] function is called once for each object or list
  /// property that has been parsed during decoding. The `key` argument is either
  /// the integer list index for a list property, the string map key for object
  /// properties, or `null` for the final result.
  ///
  /// The default [reviver] (when not provided) is the identity function.
  ///
  /// Shorthand for `json.decode`. Useful if a local variable shadows the global
  /// [json] constant.
  Object json({Object Function(Object, Object) reviver}) {
    if (_decodedJson == null) {
      final String json = utf8.decode(bytes);

      if (json == null) {
        throw Exception('JSON decoding error');
      }

      _decodedJson = jsonDecode(json, reviver: reviver);
    }

    return _decodedJson;
  }

  /// Convert json body to map
  Map<String, dynamic> get toMap => json();

  /// Convert json body to list
  List<dynamic> get toList => json();

  @override
  String toString() => '$runtimeType{statusCode: $statusCode}';
}
