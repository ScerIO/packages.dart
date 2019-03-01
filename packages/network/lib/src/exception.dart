import 'package:network/src/response.dart';

class NetworkException<T extends BinaryResponse> implements Exception {
  final T response;
  NetworkException(this.response);

  int get code => response.statusCode;
}
