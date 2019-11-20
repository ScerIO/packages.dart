import 'package:network/src/exception.dart';
import 'package:network/src/middleware.dart';
import 'package:network/src/response.dart';

Middleware defaultErrors() => Middleware(
      onError: (Object error) {
        if (error is NetworkException &&
            !(error is NetworkUnavailableException)) {
          switch (error.code) {
            case 400:
              return BadRequestException(error.response);
            case 401:
              return UnauthorizedException(error.response);
            case 402:
              return PaymentRequired(error.response);
            case 403:
              return ForbiddenException(error.response);
            case 404:
              return NotFoundException(error.response);
            case 405:
              return MethodNotAllowed(error.response);
            case 500:
              return InternalServerException(error.response);
            default:
              return error;
          }
        } else {
          return error;
        }
      },
    );

/// HTTP 400
class BadRequestException<T extends BinaryResponse>
    extends NetworkException<T> {
  BadRequestException(T response) : super(response);
}

/// HTTP 401
class UnauthorizedException<T extends BinaryResponse> extends NetworkException {
  UnauthorizedException(T response) : super(response);
}

/// HTTP 402
class PaymentRequired<T extends BinaryResponse> extends NetworkException<T> {
  PaymentRequired(T response) : super(response);
}

/// HTTP 403
class ForbiddenException<T extends BinaryResponse> extends NetworkException {
  ForbiddenException(T response) : super(response);
}

/// HTTP 404
class NotFoundException<T extends BinaryResponse> extends NetworkException<T> {
  NotFoundException(T response) : super(response);
}

// HTTP 405
class MethodNotAllowed<T extends BinaryResponse> extends NetworkException<T> {
  MethodNotAllowed(T response) : super(response);
}

/// HTTP 500
class InternalServerException<T extends BinaryResponse>
    extends NetworkException<T> {
  InternalServerException(T response) : super(response);
}
