import 'dart:typed_data' show Uint8List;

import 'package:network/network.dart';

T makeResponseByType<T>(int statusCode, Uint8List bytes) {
  switch (T) {
    case JsonApiResponse:
      return JsonApiResponse(statusCode, bytes) as T;
    case BinaryResponse:
    default:
      return BinaryResponse(statusCode, bytes) as T;
  }
}
