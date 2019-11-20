import 'package:meta/meta.dart';
import 'package:network/hooks.dart';
import 'package:network/src/methods.dart';
import 'package:network/src/request.dart';
import 'package:network/src/response.dart';

T eachMiddlewareRequests<T extends Request>(
  Set<Middleware> middleware,
  T request,
) =>
    middleware.fold<Request>(
      request,
      (req, middleware) {
        if (middleware.on?.contains(req.method) ?? true) {
          final result = middleware.onRequest?.call(req);
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

T eachMiddlewareResponses<T extends Response>(
  Set<Middleware> middleware,
  T response,
) =>
    middleware.fold<Response>(
      response,
      (res, middleware) {
        if (middleware.on?.contains(res.request.method) ?? true) {
          return middleware.onResponse?.call(res);
        } else {
          return res;
        }
      },
    ) ??
    response;

void eachMiddlewareErrors<T extends Object>(
  Set<Middleware> middleware,
  T error, {
  @required HttpMethod on,
}) {
  throw middleware.fold<Object>(
        error,
        (err, middleware) {
          if (middleware.on?.contains(on) ?? true) {
            return middleware.onError?.call(err);
          } else {
            return err;
          }
        },
      ) ??
      error;
}
