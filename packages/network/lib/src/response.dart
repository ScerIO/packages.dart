import 'dart:convert' show jsonDecode, utf8;
import 'dart:typed_data' show Uint8List;

class BinaryResponse {
  /// Response status code
  final int statusCode;

  /// Response body bytes
  final Uint8List bytes;

  BinaryResponse(this.statusCode, this.bytes);

  BinaryResponse.make(this.statusCode, this.bytes);
}

class JsonApiResponse extends BinaryResponse {
  JsonApiResponse(int statusCode, Uint8List bytes) : super(statusCode, bytes);

  /// Convert json body to map
  Map<String, dynamic> get toMap {
    final String json = utf8.decode(bytes);

    if (json == null) throw Exception('JSON decoding error');

    return jsonDecode(json);
  }
}
