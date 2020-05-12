import 'package:network/src/interceptor.dart';

import 'interceptors/encode_json_body.dart';

class NetworkSettings {
  NetworkSettings._();

  factory NetworkSettings() => _instance;

  static final NetworkSettings _instance = NetworkSettings._();

  static const String _userAgentHeader = 'user-agent';

  Map<String, String> _defaultHeaders = {};

  bool get hasUserAgent => _defaultHeaders[_userAgentHeader] != null;

  set userAgent(String userAgent) {
    if (userAgent == null) {
      _defaultHeaders.remove(_userAgentHeader);
    } else {
      _defaultHeaders[_userAgentHeader] = userAgent;
    }
  }

  String get userAgent => _defaultHeaders[_userAgentHeader];

  void addDefaultHeader(String name, String value) =>
      _defaultHeaders[name] = value;

  void addDefaultHeaders(Map<String, String> headers) =>
      _defaultHeaders.addAll(headers);

  void removeDefaultHeader(String name) => _defaultHeaders.remove(name);

  Map<String, String> get defaultHeaders => Map.from(_defaultHeaders);

  Set<Interceptor> _interceptors = {
    encodeJsonBody(),
  };

  Set<Interceptor> get interceptors => _interceptors;
}
