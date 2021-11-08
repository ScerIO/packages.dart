import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:internet_file/src/storage.dart';

typedef InternetFileProcess = void Function(double percentage);

class InternetFile {
  static Future<Uint8List> get(
    String url, {
    Map<String, String>? headers,
    InternetFileProcess? process,
    InternetFileStorage? storage,
    InternetFileStorageAdditional storageAdditional = const {},
  }) async {
    final completer = Completer<Uint8List>();
    final httpClient = http.Client();
    final request = http.Request('GET', Uri.parse(url));
    if (headers != null) {
      request.headers.addAll(headers);
    }
    final response = httpClient.send(request);

    List<List<int>> chunks = [];
    int downloaded = 0;

    if (storage != null) {
      final localResult = await storage.findExist(url, storageAdditional);
      if (localResult != null) {
        return localResult;
      }
    }

    response.asStream().listen((http.StreamedResponse request) {
      request.stream.listen(
        (List<int> chunk) {
          final contentLength = request.contentLength ?? 0;
          final percentage = downloaded / contentLength * 100;
          // Display percentage of completion
          print('downloadPercentage: $percentage');
          process?.call(percentage);

          chunks.add(chunk);
          downloaded += chunk.length;
        },
        onDone: () {
          final contentLength = request.contentLength ?? 0;
          final percentage = downloaded / contentLength * 100;

          print('downloadPercentage: $percentage');
          process?.call(percentage);

          final Uint8List bytes = Uint8List(contentLength);
          int offset = 0;

          for (List<int> chunk in chunks) {
            bytes.setRange(offset, offset + chunk.length, chunk);
            offset += chunk.length;
          }
          if (storage != null) {
            storage.save(url, storageAdditional, bytes);
          }
          completer.complete(bytes);
          return;
        },
        onError: (error) {
          completer.completeError(error);
        },
      );
    });
    return completer.future;
  }
}
