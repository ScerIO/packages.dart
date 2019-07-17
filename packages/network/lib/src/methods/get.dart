import 'dart:io';
import 'dart:async' show Future;
import 'package:http/http.dart' as http show Client, Response;
import 'package:network/src/exception.dart';
import 'package:network/src/response.dart';
import 'package:network/src/settings.dart';
import 'package:network/src/utils/response_by_type.dart';
import 'package:network/src/utils/serialize_query_params.dart';

/// Sends an HTTP GET request with the given headers to the given URL, which can
/// be a [Uri] or a [String].
Future<T> get<T extends BinaryResponse>(
  url, {
  Map<String, String> headers,
  Map<String, dynamic> queryParameters = const {},
}) async {
  T response;
  final client = http.Client();
  final settings = NetworkSettings();
  final Map<String, String> allHeaders = settings.defaultHeaders;
  if (headers != null) {
    allHeaders.addAll(headers);
  }
  try {
    final http.Response httpResponse = await client.get(
        url + serializeQueryParameters(queryParameters),
        headers: allHeaders);

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
    client.close();
  }

  return response;
}
