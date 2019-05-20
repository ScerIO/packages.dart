import 'dart:io';
import 'dart:async' show Future;
import 'package:http/http.dart' as http show get, Response;
import 'package:network/src/exception.dart';
import 'package:network/src/response.dart';
import 'package:network/src/settings.dart';
import 'package:network/src/utils/response_by_type.dart';
import 'package:network/src/utils/serialize_query_params.dart';

Future<T> get<T extends BinaryResponse>(
  String url, {
  Map<String, String> headers,
  Map<String, dynamic> queryParameters = const {},
}) async {
  T response;
  final settings = NetworkSettings();
  try {
    final http.Response httpResponse = await http
        .get(url + serializeQueryParameters(queryParameters), headers: headers);

    final int statusCode = httpResponse.statusCode;

    response = makeResponseByType<T>(statusCode, httpResponse.bodyBytes);

    if (statusCode < 200 || statusCode >= 400) {
      if (settings.hasExceptionDelegate) {
        settings.exceptionDelegate(NetworkException<T>(response));
      } else {
        throw NetworkException<T>(response);
      }
    }
  } on SocketException catch (_) {
    if (settings.hasExceptionDelegate) {
      settings.exceptionDelegate(NetworkUnavailableException());
    } else {
      throw NetworkUnavailableException();
    }
  }

  return response;
}
