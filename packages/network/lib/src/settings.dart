import 'package:network/src/exception.dart';

typedef ExceptionDelegateCallbak = void Function(dynamic error);
typedef SuccessfulDelegateCallback = void Function();

class NetworkSettings {
  NetworkSettings._();

  factory NetworkSettings() => _instance;

  static final NetworkSettings _instance = NetworkSettings._();

  static const String _userAgentHeader = 'user-agent';

  Map<String, String> _defaultHeaders = {};

  ExceptionDelegateCallbak exceptionDelegate = (error) {
    if (error is NetworkException && !(error is NetworkUnavailableException)) {
      switch (error.code) {
        case 400:
          throw BadRequestException(error.response);
        case 401:
          throw UnauthorizedException(error.response);
        case 403:
          throw ForbiddenException(error.response);
        case 404:
          throw NotFoundException(error.response);
        case 500:
          throw InternalServerException(error.response);
        default:
          throw error;
      }
    } else {
      throw error;
    }
  };
  SuccessfulDelegateCallback successfulDelegate;

  bool get hasSuccessfulDelegate => successfulDelegate != null;
  bool get hasUserAgent => _defaultHeaders[_userAgentHeader] != null;

  set userAgent(String userAgent) =>
      _defaultHeaders[_userAgentHeader] = userAgent;

  String get userAgent => _defaultHeaders[_userAgentHeader];

  void clearUserAgent() => _defaultHeaders.remove(_userAgentHeader);

  void addDefaultHeader(String name, String value) =>
      _defaultHeaders[name] = value;

  void addDefaultHeaders(Map<String, String> headers) =>
      _defaultHeaders.addAll(headers);

  void removeDefaultHeader(String name) => _defaultHeaders.remove(name);

  Map<String, String> get defaultHeaders => _defaultHeaders;
}
