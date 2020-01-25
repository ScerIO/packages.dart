import 'package:network/src/exception.dart';
import 'package:network/src/interceptor.dart';
import 'package:network/src/response.dart';

Interceptor defaultErrors({
  int moreThan = 400,
}) =>
    Interceptor(
      onResponse: (res) {
        if (res.statusCode >= moreThan) {
          switch (res.statusCode) {
            case 400:
              throw BadRequestException(res);
            case 401:
              throw UnauthorizedException(res);
            case 402:
              throw PaymentRequired(res);
            case 403:
              throw ForbiddenException(res);
            case 404:
              throw NotFoundException(res);
            case 405:
              throw MethodNotAllowed(res);
            case 500:
              throw InternalServerException(res);
            default:
              throw NetworkException(res);
          }
        } else {
          return res;
        }
      },
    );

/// HTTP 400
class BadRequestException extends NetworkException {
  BadRequestException(Response response) : super(response);
}

/// HTTP 401
class UnauthorizedException extends NetworkException {
  UnauthorizedException(Response response) : super(response);
}

/// HTTP 402
class PaymentRequired extends NetworkException {
  PaymentRequired(Response response) : super(response);
}

/// HTTP 403
class ForbiddenException extends NetworkException {
  ForbiddenException(Response response) : super(response);
}

/// HTTP 404
class NotFoundException extends NetworkException {
  NotFoundException(Response response) : super(response);
}

// HTTP 405
class MethodNotAllowed extends NetworkException {
  MethodNotAllowed(Response response) : super(response);
}

/// HTTP 500
class InternalServerException extends NetworkException {
  InternalServerException(Response response) : super(response);
}
