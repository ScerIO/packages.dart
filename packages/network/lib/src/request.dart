import 'dart:convert';

import 'package:meta/meta.dart';

import 'methods.dart';

class Request {
  const Request({
    @required this.headers,
    @required this.queryParameters,
    @required this.method,
    @required this.url,
    @required this.encoding,
    @required this.body,
  });

  final Map<String, String> headers;
  final Map<String, dynamic> queryParameters;
  final HttpMethod method;
  final Uri url;
  final Encoding encoding;
  final Object body;

  Request copyWith({
    Map<String, String> headers,
    Map<String, dynamic> queryParameters,
    String url,
    Encoding encoding,
    Object body,
  }) =>
      Request(
        headers: headers ?? this.headers,
        queryParameters: queryParameters ?? this.queryParameters,
        method: this.method,
        url: url ?? this.url,
        encoding: encoding ?? this.encoding,
        body: body ?? this.body,
      );
}
