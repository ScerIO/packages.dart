import 'dart:async' show Future;
import 'dart:convert' show Encoding, jsonDecode, jsonEncode, utf8;
import 'dart:typed_data' show Uint8List;
import 'package:http/http.dart' as http show get, post, Response;

class NetworkException<T> implements Exception {
  final APIResponse<T> response;
  NetworkException(this.response);
}

class APIResponse<T> {
  final int statusCode;
  final Uint8List bytes;

  APIResponse(this.statusCode, this.bytes);

  /// Convert json body to map
  T get toMap {
    final String json = utf8.decode(bytes);

    if (json == null) throw Exception('JSON decoding error');

    return jsonDecode(json);
  }
}

Future<APIResponse<T>> get<T extends dynamic>(String url,
    {Map<String, String> headers}) async {
  final http.Response response = await http.get(url, headers: headers);

  final int statusCode = response.statusCode;

  final apiResponse = APIResponse<T>(statusCode, response.bodyBytes);

  if (statusCode < 200 || statusCode >= 400)
    throw NetworkException<T>(apiResponse);

  return apiResponse;
}

Future<APIResponse<T>> post<T extends dynamic>(
  String url, {
  Map<String, String> headers,
  body = '',
  Encoding encoding,
  bool jsonBody = true,
}) async {
  final http.Response response = await http.post(
    url,
    body: jsonBody ? jsonEncode(body) : body,
    headers: headers,
    encoding: encoding,
  );

  final int statusCode = response.statusCode;

  final apiResponse = APIResponse<T>(statusCode, response.bodyBytes);

  if (statusCode < 200 || statusCode >= 400)
    throw NetworkException<T>(apiResponse);

  return apiResponse;
}
