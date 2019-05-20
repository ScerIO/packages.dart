import 'dart:io';
import 'dart:async';
import 'dart:convert' show Encoding, jsonEncode;

import 'package:http/http.dart' as http show put, Response;
import 'package:network/src/exception.dart';
import 'package:network/src/response.dart';
import 'package:network/src/settings.dart';
import 'package:network/src/utils/response_by_type.dart';
import 'package:network/src/utils/serialize_query_params.dart';

Future<T> put<T extends BinaryResponse>(
  String url, {
  Map<String, String> headers,
  body,
  Encoding encoding,
  Map<String, dynamic> queryParameters = const {},
}) async {
  T response;
  final settings = NetworkSettings();
  try {
    final http.Response httpResponse = await http.put(
      url + serializeQueryParameters(queryParameters),
      body: body is Map ? jsonEncode(body) : body,
      headers: headers,
      encoding: encoding,
    );

    final int statusCode = httpResponse.statusCode;

    response = makeResponseByType<T>(statusCode, httpResponse.bodyBytes);

    if (statusCode < 200 || statusCode >= 400) {
      throw NetworkException<T>(response);
    }
  } on SocketException catch (_) {
    settings.exceptionDelegate(NetworkUnavailableException());
  }

  return response;
}
