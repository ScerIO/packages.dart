import 'package:network/src/middleware.dart';

import 'middlewares/encode_json_body.dart';
import 'middlewares/default_errors.dart';

typedef ExceptionDelegateCallback = void Function(dynamic error);
typedef SuccessfulDelegateCallback = void Function();

class NetworkSettings {
  NetworkSettings._();

  factory NetworkSettings() => _instance;

  static final NetworkSettings _instance = NetworkSettings._();

  static const String _userAgentHeader = 'user-agent';

  Map<String, String> _defaultHeaders = {};

  @Deprecated('Usage Middleware.error instead')
  ExceptionDelegateCallback exceptionDelegate = (error) {
    throw defaultErrors().onError(error);
  };
  @Deprecated('Usage Middleware.response instead')
  SuccessfulDelegateCallback successfulDelegate;

  @deprecated
  // ignore: deprecated_member_use_from_same_package
  bool get hasSuccessfulDelegate => successfulDelegate != null;

  bool get hasUserAgent => _defaultHeaders[_userAgentHeader] != null;

  set userAgent(String userAgent) {
    if (userAgent == null) {
      _defaultHeaders.remove(_userAgentHeader);
    } else {
      _defaultHeaders[_userAgentHeader] = userAgent;
    }
  }

  String get userAgent => _defaultHeaders[_userAgentHeader];

  @Deprecated('Usage .userAgent = null instead')
  void clearUserAgent() => _defaultHeaders.remove(_userAgentHeader);

  void addDefaultHeader(String name, String value) =>
      _defaultHeaders[name] = value;

  void addDefaultHeaders(Map<String, String> headers) =>
      _defaultHeaders.addAll(headers);

  void removeDefaultHeader(String name) => _defaultHeaders.remove(name);

  Map<String, String> get defaultHeaders => Map.from(_defaultHeaders);

  Set<Middleware> _middleware = {
    encodeJsonBody(),
  };

  Set<Middleware> get middleware => _middleware;

  bool legacyDisabled = false;
  void disableLegacy() => legacyDisabled = true;
}

final settings = NetworkSettings();
