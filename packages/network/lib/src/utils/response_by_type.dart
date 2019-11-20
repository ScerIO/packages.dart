import 'dart:typed_data' show Uint8List;

import 'package:network/src/request.dart';
import 'package:network/src/response.dart';

Res makeResponseByType<Res extends Response>(
  int statusCode,
  Uint8List bytes,
  Request request,
) {
  switch (Res) {
    case JsonApiResponse:
      return JsonApiResponse(
        statusCode: statusCode,
        bytes: bytes,
        request: request,
      ) as Res;
    case BinaryResponse:
    default:
      return BinaryResponse(
        statusCode: statusCode,
        bytes: bytes,
        request: request,
      ) as Res;
  }
}
