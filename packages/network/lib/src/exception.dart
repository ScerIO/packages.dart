import 'package:network/src/request.dart';
import 'package:network/src/response.dart';

class NetworkException implements Exception {
  const NetworkException(this.response);

  final Response response;

  Request get request => response.request;

  int get code => response.statusCode;

  @override
  String toString() => '$runtimeType{code: $code}';
}
