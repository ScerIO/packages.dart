import 'dart:convert';

import 'package:network/src/response.dart';

import 'network.dart';

Future<Response> head(
  url, {
  Map<String, String> headers,
  Map<String, dynamic> queryParameters = const {},
}) =>
    _withClient((client) => client.head(
          url,
          headers: headers,
          queryParameters: queryParameters,
        ));

Future<Response> delete(
  url, {
  Map<String, String> headers,
  Map<String, dynamic> queryParameters = const {},
}) =>
    _withClient((client) => client.delete(
          url,
          headers: headers,
          queryParameters: queryParameters,
        ));

Future<Response> get(
  url, {
  Map<String, String> headers,
  Map<String, dynamic> queryParameters = const {},
}) =>
    _withClient((client) => client.get(
          url,
          headers: headers,
          queryParameters: queryParameters,
        ));

Future<Response> patch(
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

Future<Response> post(
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

Future<Response> put(
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

Future<Response> _withClient<T>(Future<Response> fn(Network client)) async {
  var client = Network();
  try {
    return await fn(client);
  } finally {
    client.close();
  }
}
