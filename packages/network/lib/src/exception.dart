import 'package:network/src/request.dart';
import 'package:network/src/response.dart';

class NetworkException<T extends BinaryResponse> implements Exception {
  NetworkException(this.response);

  final T response;

  Request get request => response?.request;

  int get code => response?.statusCode;

  @override
  String toString() => '$runtimeType{code: $code}';
}

class NetworkUnavailableException implements Exception {
  NetworkUnavailableException(this.request);

  final Request request;
}
