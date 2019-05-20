typedef ExceptionDelegateCallbak = void Function(dynamic error);

class NetworkSettings {
  NetworkSettings._();

  factory NetworkSettings() => _instance;

  static final NetworkSettings _instance = NetworkSettings._();

  ExceptionDelegateCallbak exceptionDelegate = (error) {
    throw error;
  };

  bool get hasExceptionDelegate => exceptionDelegate != null;
}
