[comment]: <> (Changelog bum example)
[comment]: <> (## version)
[comment]: <> (### Breaking Changes or ### New Features)
[comment]: <> (* Change description)

## 0.10.0-dev.1

* Removed legacy code
* Added browser support
* Removed `NoInternetConnection` exception (Usage instead `SocketException` for vm / flutter and `http.ClientError` for browser)
* `BinaryResponse` and `JsonApiResponse` now just `Response` with `Response.{json(), toMap, toList}` methods
* Added optionally `reviver` function for `Response.json()`

## 0.9.3

* Fixed client

## 0.9.2

* Fixed middleware

## 0.9.1

* Fixed error on empty middleware methods

## 0.9.0

* Added optional http.Client argument `Network(http.Client())`
* Added (local) middlewares for client `Network().middleware.add()`

## 0.8.0

* Added global middleware! Usage example:
```dart
network.settings.middleware.add(
  network.Middleware(
    onRequest: (request) => request,
    onResponse: (response) => response,
    onError: (error) => error,
  )
);
```
* Simplify usage settings (`network.NetworkSettings()...` -> `network.settings...`) 
* `NetworkSettings.{exceptionDelegate, successfulDelegate, hasSuccessfulDelegate}` marked as deprecated ann will be removed in 1.0.0
* Usage as client available!
```dart
import 'package:network/network.dart';
final client = Network();
client.get(...);
client.post(...);
client.close();
```
* Added `network.head()` method
* Added `Response.request`
* Added `PaymentRequired` & `MethodNotAllowed` http exceptions;

## 0.7.1

* Fix default headers

## 0.7.0 

* Added property to use an external http-client

## 0.6.0

* Added `userAgent` (available in Settings)
* Added `defaultHeaders` (available in Settings)
* Added default http exceptions (like a unauthorized, not found etc)

## 0.5.0 

* Refactoring

## 0.4.0

* Added `NetworkUnavailableException`
* Fixed `exceptionDelegate`

## 0.3.0

* Added `NetworkSettings`
* Added `exceptionDelegate` in `NetworkSettings`

## 0.2.0

* Added `toString()` method for `NetworkException` and `BinaryResponse`
* Added `toJsonApiResponse()` method for `BinaryResponse`

## 0.1.0

* Added parameter `queryParameters` for all methods
* Removed parameter `jsonBody` from *post* and *put* methods

## 0.0.2

* Removed debug print
* Added hooks for `delete` & `put` http methods

## 0.0.1

* Initial release
