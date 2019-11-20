import 'dart:convert' show jsonDecode, utf8;
import 'dart:typed_data' show Uint8List;

import 'package:meta/meta.dart';
import 'package:network/src/request.dart';

abstract class Response {
  /// Response status code
  final int statusCode;

  /// Response body bytes
  final Uint8List bytes;

  final Request request;

  const Response(this.statusCode, this.bytes, this.request);
}

class BinaryResponse implements Response {
  /// Response status code
  @override
  final int statusCode;

  /// Response body bytes
  @override
  final Uint8List bytes;

  @override
  final Request request;

  /// Raw binary response
  BinaryResponse({
    @required this.statusCode,
    @required this.bytes,
    @required this.request,
  });

  @Deprecated('Will be removed in v1.0.0, use BinaryResponse() instead')
  const BinaryResponse.make({
    @required this.statusCode,
    @required this.bytes,
    @required this.request,
  });

  @override
  String toString() => '$runtimeType{statusCode: $statusCode}';

  JsonApiResponse toJsonApiResponse() => JsonApiResponse(
        statusCode: statusCode,
        bytes: bytes,
        request: request,
      );
}

class JsonApiResponse extends BinaryResponse {
  /// Json api response
  JsonApiResponse({
    @required int statusCode,
    @required Uint8List bytes,
    @required Request request,
  }) : super(
          statusCode: statusCode,
          bytes: bytes,
          request: request,
        );

  Object _decoded;

  Object decode() {
    if (_decoded == null) {
      final String json = utf8.decode(bytes);

      if (json == null) {
        throw Exception('JSON decoding error');
      }

      _decoded = jsonDecode(json);
    }

    return _decoded;
  }

  /// Convert json body to map
  Map<String, dynamic> get toMap => decode();

  /// Convert json body to list
  List<dynamic> get toList => decode();
}
