import 'dart:typed_data';

typedef InternetFileStorageAdditional = Map<String, Object>;

abstract class InternetFileStorage {
  Future<void> save(
    String url,
    InternetFileStorageAdditional additional,
    Uint8List bytes,
  );

  Future<Uint8List?> findExist(
    String url,
    InternetFileStorageAdditional additional,
  );
}
