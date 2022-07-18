import 'dart:typed_data';

import 'package:universal_file/universal_file.dart';
import 'package:path/path.dart' as p;

import 'package:internet_file/src/storage.dart';

class InternetFileStorageIO extends InternetFileStorage {
  @override
  Future<Uint8List?> findExist(
    String url,
    InternetFileStorageAdditional additional,
  ) {
    final file = _fileByAdditional(additional);

    return file.existsSync() ? file.readAsBytes() : Future.value(null);
  }

  @override
  Future<void> save(
    String url,
    InternetFileStorageAdditional additional,
    Uint8List bytes,
  ) async {
    final file = _fileByAdditional(additional);
    await file.writeAsBytes(bytes);
  }

  File _fileByAdditional(InternetFileStorageAdditional additional) {
    assert(
      additional.containsKey('filename') && additional['filename'] is String,
      'Requires additional params with key [filename] and String value',
    );
    assert(
      additional.containsKey('location') && additional['location'] is String,
      'Requires additional params with key [location] and String value',
    );
    final file = File(p.join(
      additional['location']! as String,
      additional['filename']! as String,
    ));
    return file;
  }

  Map<String, String> additional({
    required String filename,
    required String location,
  }) =>
      {
        'location': location,
        'filename': filename,
      };
}
