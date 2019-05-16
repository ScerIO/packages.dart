import 'package:network/src/response.dart';

class NetworkException<T extends BinaryResponse> implements Exception {
  NetworkException(this.response);

  final T response;

  int get code => response.statusCode;

  @override
  String toString() => '$runtimeType{code: $code}';
}
