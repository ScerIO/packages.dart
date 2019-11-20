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

* Simple hooks for get / post
* Specify response type (blob\json api)

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

For new users (0.8.0+) before all usages need disable backward compatibility
```dart
network.settings.disableLegacy();
```

Get request to API:
```dart
final restResponse = await network.get<network.JsonApiResponse>(
  'https://jsonplaceholder.typicode.com/todos/1',
  queryParameters: {'name': 'value'}
);
print(restResponse.toMap['title']);
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
final postResponse = await network.post<network.JsonApiResponse>(
  'https://jsonplaceholder.typicode.com/todos',
  body: {'title': 'test'},
);
print(postResponse.toMap['id']);
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
import 'package:network/middlewares.dart';

network.settings.middleware.addAll([
  defaultErrors(),
  network.Middleware(
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
```

And... all api docs [available here](https://pub.dartlang.org/documentation/network/latest/)

## Credits
This software uses the following open source packages:
* [http](https://pub.dartlang.org/packages/http)
