import 'dart:convert' show jsonEncode;

import 'package:network/src/methods.dart';
import 'package:network/src/middleware.dart';

Middleware encodeJsonBody() => Middleware(
        on: {
          HttpMethod.path,
          HttpMethod.post,
          HttpMethod.put,
        },
        onRequest: (req) {
          if (req.body != null && (req.body is Map || req.body is List)) {
            return req.copyWith(
              body: jsonEncode(req.body),
            );
          } else {
            return req;
          }
        });
