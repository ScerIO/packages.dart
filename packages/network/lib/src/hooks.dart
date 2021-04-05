import 'dart:convert';

import 'package:network/src/response.dart';

import 'network.dart';

Future<Response> _withClient<T>(
    Future<Response> fn(NetworkClient client)) async {
  var client = NetworkClient();
  try {
    return await fn(client);
  } finally {
    client.close();
  }
}

extension NetworkHooks on String {
  Future<Response> head({
    Map<String, String>? headers,
    Map<String, dynamic> queryParameters = const {},
  }) =>
      _withClient((client) => client.head(
            this,
            headers: headers,
            queryParameters: queryParameters,
          ));

  Future<Response> delete({
    Map<String, String>? headers,
    Map<String, dynamic> queryParameters = const {},
  }) =>
      _withClient((client) => client.delete(
            this,
            headers: headers,
            queryParameters: queryParameters,
          ));

  Future<Response> get({
    Map<String, String>? headers,
    Map<String, dynamic> queryParameters = const {},
  }) =>
      _withClient((client) => client.get(
            this,
            headers: headers,
            queryParameters: queryParameters,
          ));

  Future<Response> patch({
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Map<String, dynamic> queryParameters = const {},
  }) =>
      _withClient((client) => client.patch(
            this,
            headers: headers,
            body: body,
            encoding: encoding,
            queryParameters: queryParameters,
          ));

  Future<Response> post({
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Map<String, dynamic> queryParameters = const {},
  }) =>
      _withClient((client) => client.post(
            this,
            headers: headers,
            body: body,
            encoding: encoding,
            queryParameters: queryParameters,
          ));

  Future<Response> put({
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Map<String, dynamic> queryParameters = const {},
  }) =>
      _withClient((client) => client.put(
            this,
            headers: headers,
            body: body,
            encoding: encoding,
            queryParameters: queryParameters,
          ));
}
