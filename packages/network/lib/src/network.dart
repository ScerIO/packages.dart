import 'dart:io' show SocketException;
import 'dart:convert' show Encoding;
import 'package:http/http.dart' as http show Client, Request, Response;
import 'package:meta/meta.dart';
import 'package:network/src/exception.dart';
import 'package:network/src/middleware.dart';
import 'package:network/src/request.dart';

import 'package:network/src/response.dart';
import 'package:network/src/settings.dart';
import 'package:network/src/utils/helpers.dart';
import 'package:network/src/utils/response_by_type.dart';
import 'package:network/src/utils/serialize_query_params.dart';

import 'methods.dart';

class Network {
  Network([http.Client client]) : client = client ?? http.Client;
  final http.Client client;

  Set<Middleware> _middleware = {};

  Set<Middleware> get middleware => _middleware;

  Future<T> head<T extends BinaryResponse>(
    url, {
    Map<String, String> headers,
    Map<String, dynamic> queryParameters = const {},
  }) {
    return send(
      url,
      method: HttpMethod.head,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  Future<T> delete<T extends BinaryResponse>(
    url, {
    Map<String, String> headers,
    Map<String, dynamic> queryParameters = const {},
  }) {
    return send(
      url,
      method: HttpMethod.delete,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  Future<T> get<T extends BinaryResponse>(
    url, {
    Map<String, String> headers,
    Map<String, dynamic> queryParameters = const {},
  }) {
    return send(
      url,
      method: HttpMethod.get,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  Future<T> patch<T extends BinaryResponse>(
    url, {
    Map<String, String> headers,
    Object body,
    Encoding encoding,
    Map<String, dynamic> queryParameters = const {},
  }) {
    return send(
      url,
      method: HttpMethod.path,
      headers: headers,
      body: body,
      encoding: encoding,
      queryParameters: queryParameters,
    );
  }

  Future<T> post<T extends BinaryResponse>(
    url, {
    Map<String, String> headers,
    Object body,
    Encoding encoding,
    Map<String, dynamic> queryParameters = const {},
  }) {
    return send(
      url,
      method: HttpMethod.post,
      headers: headers,
      body: body,
      encoding: encoding,
      queryParameters: queryParameters,
    );
  }

  Future<T> put<T extends BinaryResponse>(
    url, {
    Map<String, String> headers,
    Object body,
    Encoding encoding,
    Map<String, dynamic> queryParameters = const {},
  }) {
    return send(
      url,
      method: HttpMethod.put,
      headers: headers,
      body: body,
      encoding: encoding,
      queryParameters: queryParameters,
    );
  }

  Future<T> send<T extends BinaryResponse>(
    url, {
    @required HttpMethod method,
    Map<String, String> headers,
    Object body,
    Encoding encoding,
    Map<String, dynamic> queryParameters = const {},
  }) async {
    assert(url is Uri || url is String);
    T response;
    final settings = NetworkSettings();
    final Map<String, String> allHeaders = settings.defaultHeaders;
    if (headers != null) {
      allHeaders.addAll(headers);
    }

    final request = eachMiddlewareRequests(
      {...settings.middleware, ..._middleware},
      Request(
        headers: allHeaders,
        method: method,
        queryParameters: queryParameters,
        url: url is String ? Uri.parse(url) : url,
        encoding: encoding,
        body: body,
      ),
    );

    try {
      final http.Response httpResponse = await _sendUnstreamed(
        httpMethodString(method),
        request.url.toString() +
            serializeQueryParameters(request.queryParameters),
        body: request.body,
        headers: request.headers,
        encoding: request.encoding,
      );

      final int statusCode = httpResponse.statusCode;

      response = eachMiddlewareResponses(
        {...settings.middleware, ..._middleware},
        makeResponseByType<T>(
          statusCode,
          httpResponse.bodyBytes,
          request,
        ),
      );

      if (!settings.legacyDisabled) {
        // Will be removed and replaced by middlewares/throw_on_status_codes
        if (statusCode < 200 || statusCode >= 400) {
          // ignore: deprecated_member_use_from_same_package
          settings.exceptionDelegate(NetworkException<T>(response));
        } else {
          // ignore: deprecated_member_use_from_same_package
          if (settings.hasSuccessfulDelegate) {
            // ignore: deprecated_member_use_from_same_package
            settings.successfulDelegate();
          }
        }
      }
    } on SocketException catch (_) {
      if (!settings.legacyDisabled) {
        // ignore: deprecated_member_use_from_same_package
        settings.exceptionDelegate(NetworkUnavailableException(request));
      }
      eachMiddlewareErrors(
        {...settings.middleware, ..._middleware},
        NetworkUnavailableException(request),
        on: method,
      );
    }

    return response;
  }

  /// Sends a non-streaming [Request] and returns a non-streaming [Response].
  Future<http.Response> _sendUnstreamed(
    String method,
    url, {
    Map<String, String> headers,
    body,
    Encoding encoding,
  }) async {
    if (url is String) url = Uri.parse(url);
    http.Request request = new http.Request(method, url);

    if (headers != null) request.headers.addAll(headers);
    if (encoding != null) request.encoding = encoding;
    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = body.cast<int>();
      } else if (body is Map) {
        request.bodyFields = body.cast<String, String>();
      } else {
        throw new ArgumentError('Invalid request body "$body".');
      }
    }

    return http.Response.fromStream(await client.send(request));
  }

  void close() {
    client.close();
  }
}
