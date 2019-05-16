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

Get request to API:
```dart
main() async {
  final getResponse = await network.get<network.JsonApiResponse>(
      'https://jsonplaceholder.typicode.com/todos/1');
  print(getResponse.toMap['title']);
}
``` 
Get request Blob:
```dart
main() async {
  final blobResponse = await network.get(
      'https://via.placeholder.com/300');
  print(blobResponse.bytes);
}
```

Post request to API:
```dart
final postResponse = await network.post<network.JsonApiResponse>(
      'https://jsonplaceholder.typicode.com/todos',
      body: {'title': 'test'});
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

And... api reference [available here](https://pub.dartlang.org/documentation/network/latest/)

## TODO
- [x] Get
- [x] Post
- [x] Delete
- [x] Put
- [ ] Decorators (#1)

## Credits
This software uses the following open source packages:
* [http](https://pub.dartlang.org/packages/http)
