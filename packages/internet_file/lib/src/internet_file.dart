import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:internet_file/src/storage.dart';

@Deprecated('Usage `progress` instead')
typedef InternetFileProcess = void Function(double percentage);
typedef InternetFileProgress = void Function(
  int receivedLength,
  int contentLength,
);

class InternetFile {
  static Future<Uint8List> get(
    String url, {
    Map<String, String>? headers,
    // ignore: deprecated_member_use_from_same_package
    @Deprecated('Usage `progress` instead') InternetFileProcess? process,
    InternetFileProgress? progress,
    InternetFileStorage? storage,
    InternetFileStorageAdditional storageAdditional = const {},
    bool force = false,
    String method = 'GET',
    bool debug = false,
  }) async {
    final completer = Completer<Uint8List>();
    final httpClient = http.Client();
    final request = http.Request(method, Uri.parse(url));
    if (headers != null) {
      request.headers.addAll(headers);
    }
    final response = httpClient.send(request);

    List<int> bytesList = [];
    int receivedLength = 0;

    if (storage != null) {
      final localResult = await storage.findExist(url, storageAdditional);
      if (localResult != null && !force) {
        return localResult;
      }
    }

    response.asStream().listen((http.StreamedResponse request) {
      request.stream.listen(
        (List<int> chunk) {
          receivedLength += chunk.length;
          final contentLength = request.contentLength ?? receivedLength;
          final percentage = receivedLength / contentLength * 100;

          if (debug) {
            print('download progress: $receivedLength of '
                '$contentLength ($percentage%)');
          }
          process?.call(percentage);
          progress?.call(receivedLength, contentLength);

          bytesList.addAll(chunk);
        },
        onDone: () {
          final bytes = Uint8List.fromList(bytesList);

          if (storage != null) {
            if (debug) {
              print('Save file in storage...');
            }
            storage.save(url, storageAdditional, bytes);
          }
          completer.complete(bytes);
        },
        onError: completer.completeError,
      );
    }, onError: completer.completeError);
    return completer.future;
  }
}
