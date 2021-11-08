<h2 align="center">A cross-platform File & Directory that works in all platforms (browsers, mobile, desktop, and server-side)</h2>
<br />
<p align="center">
  <a href="https://pub.dev/packages/universal_file">
    <img src="https://img.shields.io/pub/v/universal_file.svg"
         alt="Pub">
  </a>
</p>

<p align="center">
  <a href="#purpose">Purpose</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#credits">Credits</a>
</p>

## Purpose

The purpose of the library is to be able to use the file everywhere. Nothing more superfluous - just a File, Directory and Link

## Getting Started

Just import
```dart
import 'package:universal_file/universal_file.dart';

// And usage anywhere with backward capability!
try {
  final file = File('$object.txt');
  if (await file.exists()) {
    final modified = await file.lastModified();
    print(
        'File for $object already exists. It was modified on $modified.');
    continue;
  }
  await file.create();
  await file.writeAsString('Start describing $object in this file.');
  final description = await file.readAsString();
  print(description);
} on IOException catch (e) {
  print('Cannot create description for $object: $e');
}
```

Full api reference [available here](https://pub.dev/documentation/register/latest/)

## Credits
This software is decomposition of [universal_io] (Removed all except FileSystem):
* [universal_io](https://github.com/dint-dev/universal_io)