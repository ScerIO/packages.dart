<img src="https://raw.githubusercontent.com/rbcprolabs/packages.dart/master/packages/internet_file/media/hero.png" alt="Logo" width="100%" />
<br />
<h2 align="center">A internet file getter (also optional downloader) that works in all platforms (browsers, mobile, desktop, and server-side)</h2>
<br />
<p align="center">
  <a href="https://pub.dev/packages/internet_file">
    <img src="https://img.shields.io/pub/v/internet_file.svg"
         alt="Pub">
  </a>
</p>

<p align="center">
  <a href="#purpose">Purpose</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#api">Api</a> •
  <a href="#credits">Credits</a>
</p>

## Purpose
The library is made to allow direct access to Internet files on all platforms. 
It also has the middleware to store files locally if needed. 
Aimed primarily at use with plugins, without the ability to work with the Internet

## Getting Started

Simple usage anywhere:
```dart
import 'package:internet_file/internet_file.dart';

final Uint8List bytes = await InternetFile.get(
    'https://github.com/rbcprolabs/icon_font_generator/raw/master/example/lib/icon_font/ui_icons.ttf',
    progress: (receivedLength, contentLength) {
      final percentage = receivedLength / contentLength * 100;
      print(
          'download progress: $receivedLength of $contentLength ($percentage%)');
    },
);
```

For local store files you can usage `InternetFileStorageIO` (not works on web):
```dart
import 'package:internet_file/storage_io.dart';

final storageIO = InternetFileStorageIO();

await InternetFile.get(
    'https://github.com/rbcprolabs/icon_font_generator/raw/master/example/lib/icon_font/ui_icons.ttf',
    storage: storageIO,
    storageAdditional: storageIO.additional( 
      filename: 'ui_icons.ttf',
      location: '',
    ),
);
```

Or you can write you own storage not requires io (web support etc.):
```dart
class MyOwnInternetFileStorage extends InternetFileStorage {
  @override
  Future<Uint8List?> findExist(
    String url,
    InternetFileStorageAdditional additional,
  ) {
    # find local here

    # access you own string property:
    print(additional['my_string_property'] as String);

    # access you own any type property:
    print((additional['my_date_property'] as DateTime).toString())
  }

  @override
  Future<void> save(
    String url,
    InternetFileStorageAdditional additional,
    Uint8List bytes,
  ) async {
    # save file here
  }
}

final myOwnStorage = MyOwnInternetFileStorage();
await InternetFile.get(
    'https://github.com/rbcprolabs/icon_font_generator/raw/master/example/lib/icon_font/ui_icons.ttf',
    storage: myOwnStorage,
    storageAdditional: {
        'my_string_property': 'string',
        'my_int_property': 99,
        'my_date_property': DateTime.now(),
    },
);
```
## Api

__InternetFile.get params__

| Parameter         | Description                                                                          | Optional | Default |
|-------------------|--------------------------------------------------------------------------------------|----------|---------|
| url               | Link to network file                                                                 | required | -       |
| headers           | Headers passed for wile load                                                         | optional | -       |
| progress          | Callback with received & all bytes length progress value called when file loads      | optional | -       |
| storage           | Implements of `InternetFileStorage` with save & find local methods for saving files  | optional | -       |
| storageAdditional | Additional args for pass to `InternetFileStorage` implementation passed in `storage` | optional | {}      |

Full api reference [available here](https://pub.dev/documentation/register/latest/)

## Credits
Inspired by [flutter_cache_manager](https://pub.dev/packages/flutter_cache_manager), but make for support all platforms

Uses:
* [http](https://pub.dev/packages/http) - for file loading from internet
* [path](https://pub.dev/packages/path) - for filename & location joint in `InternetFileStorageIO`
* [universal_file](https://pub.dev/packages/universal_file) - for work File in web

Created for usage in:
* [pdfx](https://pub.dev/packages/pdfx)
* [native_pdf_renderer](https://pub.dev/packages/native_pdf_renderer)
* [native_pdf_view](https://pub.dev/packages/native_pdf_renderer)
* [epub_view](https://pub.dev/packages/epub_view)
