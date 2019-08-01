import 'dart:io';
import 'dart:async';
import 'dart:convert' show Encoding, jsonEncode;

import 'package:http/http.dart' as http show Client, Response;
import 'package:network/src/exception.dart';
import 'package:network/src/response.dart';
import 'package:network/src/settings.dart';
import 'package:network/src/utils/response_by_type.dart';
import 'package:network/src/utils/serialize_query_params.dart';

Future<T> patch<T extends BinaryResponse>(
  url, {
  Map<String, String> headers,
  body,
  Encoding encoding,
  Map<String, dynamic> queryParameters = const {},
  http.Client client,
  bool autoCloseClient = true,
}) async {
  T response;
  client ??= http.Client();
  final settings = NetworkSettings();
  final Map<String, String> allHeaders = settings.defaultHeaders;
  if (headers != null) {
    allHeaders.addAll(headers);
  }
  try {
    final http.Response httpResponse = await client.patch(
      url + serializeQueryParameters(queryParameters),
      body: body is Map ? jsonEncode(body) : body,
      headers: allHeaders,
      encoding: encoding,
    );

    final int statusCode = httpResponse.statusCode;

    response = makeResponseByType<T>(statusCode, httpResponse.bodyBytes);

    if (statusCode < 200 || statusCode >= 400) {
      settings.exceptionDelegate(NetworkException<T>(response));
    } else {
      if (settings.hasSuccessfulDelegate) {
        settings.successfulDelegate();
      }
    }
  } on SocketException catch (_) {
    settings.exceptionDelegate(NetworkUnavailableException());
  } finally {
    if (autoCloseClient) {
      client.close();
    }
  }

  return response;
}
