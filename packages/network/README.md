<img src="https://raw.githubusercontent.com/rbcprolabs/dart_plugins/master/packages/network/media/hero.png" alt="Logo" width="100%" />

<p align="center">Package including hooks for easy works with http package in <a href="https://www.dartlang.org/" target="_blank">dart</a>.</p>

<p align="center">
  <a href="https://pub.dartlang.org/packages/network">
    <img src="https://img.shields.io/pub/v/network.svg"
         alt="Pub">
  </a>
</p>

<p align="center">
  <a href="#key-features">Key Features</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#todo">Todo</a> •
  <a href="#credits">Credits</a>
</p>

## Key Features

* Simple hooks for all http methods
* Interceptors witch handling requests, responses and errors
* Decode json from response (`Response.json()` / `Response.asMap` / `Response.asList`) 
* Browser support

## Getting Started

```dart
// Simplify usage
import 'package:network/hooks.dart' as network;
network.get(...);
network.post(...);

// Alternative usage
import 'package:network/network.dart';
final client = Network();
client.get(...);
client.post(...);
client.close();
``` 

Get request:
```dart
final restResponse = await network.get(
  'https://jsonplaceholder.typicode.com/todos/1',
  queryParameters: {'name': 'value'}
);
// Auto decode json response
print(restResponse.asMap['title']);
// Also available lists
print(restResponse.asList[0]);
// Or object
print(restResponse.json()); // returns Object 
// Or pure string
print(restResponse.asString);
``` 
Get request Blob:
```dart
final blobResponse = await network.get(
  'https://via.placeholder.com/300',
);
print(blobResponse.bytes);
```

Post request to API:
```dart
final postResponse = await network.post(
  'https://jsonplaceholder.typicode.com/todos',
  body: {'title': 'test'},
);
print(postResponse.asMap['id']);
```

Handle exceptions:
```dart
try {
  await network.get('https://jsonplaceholder.typicode.com/todos/202');
} on network.NetworkException catch (error) {
  print('Network exception called, status code: ${error.code}');
}
```

Add middleware:
```dart
import 'package:network/interceptors.dart';

network.settings.interceptors.addAll([
  defaultErrors(),
  network.Interceptor(
    onRequest: (request) {
      print('request on: ${request.url}');
      return request.copyWith(
        url: request.url + '/additional-link',
      );
    },
    onResponse: (response) {
      print('response status code: ${response.statusCode}');
      return response;
    },
    onError: (error) {
      if (error is UnauthorizedException) {
        signOut();
      }

      return error;
    },
  )
]);
// Also can add middleware specify for client:
final client = Network()..interceptors.add(...);
client.get(...) // Usages global (network.settings.interceptors) and local (client) interceptors
```

And... all api docs [available here](https://pub.dartlang.org/documentation/network/latest/)

## Credits
This software uses the following open source packages:
* [http](https://pub.dartlang.org/packages/http)
