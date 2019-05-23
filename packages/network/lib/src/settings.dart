typedef ExceptionDelegateCallbak = void Function(dynamic error);
typedef SuccessfulDelegateCallback = void Function();

class NetworkSettings {
  NetworkSettings._();

  factory NetworkSettings() => _instance;

  static final NetworkSettings _instance = NetworkSettings._();

  ExceptionDelegateCallbak exceptionDelegate = (error) {
    throw error;
  };
  SuccessfulDelegateCallback successfulDelegate;

  bool get hasExceptionDelegate => exceptionDelegate != null;
  bool get hasSuccessfulDelegate => successfulDelegate != null;
}
