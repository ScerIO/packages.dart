import 'package:network/network.dart';
import 'package:network/src/request.dart';
import 'package:network/src/response.dart';

import 'methods.dart';

class Interceptor {
  const Interceptor({
    this.on,
    this.onRequest,
    this.onResponse,
    this.onError,
  });

  /// Will be applied only to http methods of a certain type
  /// By default (null) appends to all methods
  final Set<HttpMethod>? on;

  final Request Function(Request request)? onRequest;

  final Response Function(Response response)? onResponse;

  final Object Function(Object error)? onError;
}
