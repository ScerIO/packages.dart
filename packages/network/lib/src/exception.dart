import 'package:network/src/response.dart';

class NetworkException<T extends BinaryResponse> implements Exception {
  NetworkException(this.response);

  final T response;

  int get code => response.statusCode;

  @override
  String toString() => '$runtimeType{code: $code}';
}

class NetworkUnavailableException implements Exception {}

/// HTTP 400
class BadRequestException<T extends BinaryResponse>
    extends NetworkException<T> {
  BadRequestException(T response) : super(response);
}

/// HTTP 401
class UnauthorizedException<T extends BinaryResponse> extends NetworkException {
  UnauthorizedException(T response) : super(response);
}

/// HTTP 403
class ForbiddenException<T extends BinaryResponse> extends NetworkException {
  ForbiddenException(T response) : super(response);
}

/// HTTP 404
class NotFoundException<T extends BinaryResponse> extends NetworkException<T> {
  NotFoundException(T response) : super(response);
}

/// HTTP 500
class InternalServerException<T extends BinaryResponse>
    extends NetworkException<T> {
  InternalServerException(T response) : super(response);
}
