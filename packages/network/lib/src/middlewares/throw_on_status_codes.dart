import 'package:network/network.dart';

Middleware throwOnStatusCodes({
  int lessThan = 199,
  int moreThan = 400,
}) =>
    Middleware(onResponse: (res) {
      if (res.statusCode < 200 || res.statusCode >= 400) {
        if (res is JsonApiResponse) {
          throw NetworkException<JsonApiResponse>(res);
        } else {
          throw NetworkException<BinaryResponse>(res);
        }
      }

      return res;
    });
