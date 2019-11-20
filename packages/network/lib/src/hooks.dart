import 'dart:convert';

import 'package:network/src/response.dart';

import 'network.dart';

Future<T> head<T extends BinaryResponse>(
  url, {
  Map<String, String> headers,
  Map<String, dynamic> queryParameters = const {},
}) =>
    _withClient((client) => client.head(
          url,
          headers: headers,
          queryParameters: queryParameters,
        ));

Future<T> delete<T extends BinaryResponse>(
  url, {
  Map<String, String> headers,
  Map<String, dynamic> queryParameters = const {},
}) =>
    _withClient((client) => client.delete(
          url,
          headers: headers,
          queryParameters: queryParameters,
        ));

Future<T> get<T extends BinaryResponse>(
  url, {
  Map<String, String> headers,
  Map<String, dynamic> queryParameters = const {},
}) =>
    _withClient((client) => client.get(
          url,
          headers: headers,
          queryParameters: queryParameters,
        ));

Future<T> patch<T extends BinaryResponse>(
  url, {
  Map<String, String> headers,
  Object body,
  Encoding encoding,
  Map<String, dynamic> queryParameters = const {},
}) =>
    _withClient((client) => client.patch(
          url,
          headers: headers,
          body: body,
          encoding: encoding,
          queryParameters: queryParameters,
        ));

Future<T> post<T extends BinaryResponse>(
  url, {
  Map<String, String> headers,
  Object body,
  Encoding encoding,
  Map<String, dynamic> queryParameters = const {},
}) =>
    _withClient((client) => client.post(
          url,
          headers: headers,
          body: body,
          encoding: encoding,
          queryParameters: queryParameters,
        ));

Future<T> put<T extends BinaryResponse>(
  url, {
  Map<String, String> headers,
  Object body,
  Encoding encoding,
  Map<String, dynamic> queryParameters = const {},
}) =>
    _withClient((client) => client.put(
          url,
          headers: headers,
          body: body,
          encoding: encoding,
          queryParameters: queryParameters,
        ));

Future<T> _withClient<T>(Future<T> fn(Network client)) async {
  var client = Network();
  try {
    return await fn(client);
  } finally {
    client.close();
  }
}
