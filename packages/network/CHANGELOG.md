[comment]: <> (Changelog bum example)
[comment]: <> (## version)
[comment]: <> (### Breaking Changes or ### New Features)
[comment]: <> (* Change description)

## 0.10.0

* Fixed `Request.copyWith` [pull#5](https://github.com/rbcprolabs/packages.dart/pull/5)
* Removed import hooks
* Now hooks is extension for String (`'myUrl'.get()` etc)
* Added `FormData`, can be send from all network methods
* Not recommended usage import `... as network`, see new examples in readme
* Minimum dart sdk set to 2.6.0
* Network settings available at `NetworkSettings()`
* Migration guide

before: 
```dart
import 'package:network/hooks.dart' as network;
import 'package:network/interceptors.dart';

main() async {
  network.settings
    ..interceptors.addAll([
      defaultErrors(),
      network.Interceptor(
        onRequest: (request) {
          print('\nrequest: ${request.url} \n');
          return request;
        },
      )
    ]);

  try {
    final getResponse = await network.get(
        'https://jsonplaceholder.typicode.com/comments',
        queryParameters: {'postId': 1});
    print('body: ' + getResponse.asList[1]['body']);

    // Post request to api
    final postResponse = await network.post(
        'https://jsonplaceholder.typicode.com/todos',
        body: {'title': 'test'});
    print('id: ' + postResponse.asMap['id']);
  } catch (error) {}

  // Or post binary
  await network.post('https://jsonplaceholder.typicode.com/todos',
      body: [0, 0, 0, 0, 0]);
}
```

after:
```dart
import 'package:network/network.dart';
import 'package:network/interceptors.dart';

main() async {
  NetworkSettings().interceptors.addAll([
      defaultErrors(),
      Interceptor(
        onRequest: (request) {
          print('\nrequest: ${request.url} \n');
          return request;
        },
      )
    ]);

  try {
    final getResponse = await 'https://jsonplaceholder.typicode.com/comments'.get(
        queryParameters: {'postId': 1});
    print('body: ' + getResponse.asList[1]['body']);

    // Post request to api
    final postResponse = await 'https://jsonplaceholder.typicode.com/todos'.post(body: {'title': 'test'});
    print('id: ' + postResponse.asMap['id']);
  } catch (error) {}

  // Or post binary
  await 'https://jsonplaceholder.typicode.com/todos'.post(body: [0, 0, 0, 0, 0]);
}
```

## 0.10.0-dev.2

* `Middleware` renamed to `Interceptor`
* Renamed `toMap` => `asMap`, `toList` -> `asList` in `Response`
* Added `asString` in `Response`

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
