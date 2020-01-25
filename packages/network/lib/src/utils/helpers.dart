import 'package:meta/meta.dart';
import 'package:network/hooks.dart';
import 'package:network/src/interceptor.dart';
import 'package:network/src/methods.dart';
import 'package:network/src/request.dart';
import 'package:network/src/response.dart';

Request eachInterceptorRequests(
  Set<Interceptor> middleware,
  Request request,
) =>
    middleware.fold<Request>(
      request,
      (req, middleware) {
        if ((middleware.on?.contains(req.method) ?? true) &&
            middleware.onRequest != null) {
          final result = middleware.onRequest(req);
          if (result.method != req.method) {
            throw Exception('Cannot set another http method to request!');
          }
          return result;
        } else {
          return req;
        }
      },
    ) ??
    request;

Response eachInterceptorResponses(
  Set<Interceptor> middleware,
  Response response,
) =>
    middleware.fold<Response>(
      response,
      (res, middleware) {
        if ((middleware.on?.contains(res.request.method) ?? true) &&
            middleware.onResponse != null) {
          return middleware.onResponse(res);
        } else {
          return res;
        }
      },
    ) ??
    response;

Object eachInterceptorErrors(
  Set<Interceptor> middleware,
  Object error, {
  @required HttpMethod on,
}) {
  return middleware.fold<Object>(
        error,
        (err, middleware) {
          if ((middleware.on?.contains(on) ?? true) &&
              middleware.onError != null) {
            return middleware.onError(err);
          } else {
            return err;
          }
        },
      ) ??
      error;
}
