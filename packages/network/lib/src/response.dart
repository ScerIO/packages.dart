import 'dart:convert' show jsonDecode, utf8;
import 'dart:typed_data' show Uint8List;

class BinaryResponse {
  /// Response status code
  final int statusCode;

  /// Response body bytes
  final Uint8List bytes;

  /// Raw binary response
  BinaryResponse(this.statusCode, this.bytes);

  /// Do not use this.
  /// Will be removed in v1.0.0
  @deprecated
  BinaryResponse.make(this.statusCode, this.bytes);

  @override
  String toString() => '$runtimeType{statusCode: $statusCode}';

  JsonApiResponse toJsonApiResponse() => JsonApiResponse(statusCode, bytes);
}

class JsonApiResponse extends BinaryResponse {
  /// Json api response
  JsonApiResponse(int statusCode, Uint8List bytes) : super(statusCode, bytes);

  dynamic _decode() {
    final String json = utf8.decode(bytes);

    if (json == null) throw Exception('JSON decoding error');

    return jsonDecode(json);
  }

  /// Convert json body to map
  Map<String, dynamic> get toMap => _decode();

  /// Convert json body to list
  List<dynamic> get toList => _decode();
}
