import 'dart:io';
import 'dart:async' show Future;
import 'package:http/http.dart' as http show delete, Response;
import 'package:network/src/exception.dart';
import 'package:network/src/response.dart';
import 'package:network/src/settings.dart';
import 'package:network/src/utils/response_by_type.dart';
import 'package:network/src/utils/serialize_query_params.dart';

Future<T> delete<T extends BinaryResponse>(
  String url, {
  Map<String, String> headers,
  Map<String, dynamic> queryParameters = const {},
}) async {
  T response;
  final settings = NetworkSettings();
  try {
    final http.Response httpResponse = await http
        .delete(url + serializeQueryParameters(queryParameters), headers: headers);

    final int statusCode = httpResponse.statusCode;

    response = makeResponseByType<T>(statusCode, httpResponse.bodyBytes);

    if (statusCode < 200 || statusCode >= 400) {
      settings.exceptionDelegate(NetworkException<T>(response));
    }
  } on SocketException catch (_) {
    settings.exceptionDelegate(NetworkUnavailableException());
  }

  return response;
}
