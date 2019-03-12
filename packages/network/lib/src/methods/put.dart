import 'dart:async';
import 'dart:convert' show Encoding, jsonEncode;

import 'package:http/http.dart' as http show put, Response;
import 'package:network/src/exception.dart';
import 'package:network/src/response.dart';
import 'package:network/src/utils.dart';

Future<T> put<T extends BinaryResponse>(
  String url, {
  Map<String, String> headers,
  body = '',
  Encoding encoding,
  bool jsonBody = true,
}) async {
  final http.Response httpResponse = await http.put(
    url,
    body: jsonBody ? jsonEncode(body) : body,
    headers: headers,
    encoding: encoding,
  );

  final int statusCode = httpResponse.statusCode;

  final response = makeResponseByType<T>(statusCode, httpResponse.bodyBytes);

  if (statusCode < 200 || statusCode >= 400) {
    throw NetworkException<T>(response);
  }

  return response;
}
