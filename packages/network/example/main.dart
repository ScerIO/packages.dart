import 'package:network/network.dart' as network;

/// HTTP 400
class BadRequestException<T extends network.BinaryResponse>
    extends network.NetworkException<T> {
  BadRequestException(T response) : super(response);
}

/// HTTP 404
class NotFoundException<T extends network.BinaryResponse>
    extends network.NetworkException<T> {
  NotFoundException(T response) : super(response);
}

/// No connection to internet
class NoInternetConnection {}

main() async {
  network.settings
    ..middleware.add(network.Middleware(
      onRequest: (request) {
        print('\n request: ${request.url} \n');
        return request;
      },
      onError: (error) {
        if (error is network.NetworkException) {
          switch (error.code) {
            case 400:
              return BadRequestException(error.response);
            case 404:
              return NotFoundException(error.response);
            default:
              return error;
          }
        } else if (error is network.NetworkUnavailableException) {
          return NoInternetConnection();
        }

        return error;
      },
    ));

  try {
    final getResponse = await network.get<network.JsonApiResponse>(
        'https://jsonplaceholder.typicode.com/comments',
        queryParameters: {'postId': 1});
    print(getResponse.toList[1]['body']);

    // Post request to api
    final postResponse = await network.post<network.JsonApiResponse>(
        'https://jsonplaceholder.typicode.com/todos',
        body: {'title': 'test'});
    print(postResponse.toMap['id']);
  } on NoInternetConnection {
    print('No internet connection');
  }

  // Or post binary
  await network.post<network.JsonApiResponse>(
      'https://jsonplaceholder.typicode.com/todos',
      body: [0, 0, 0, 0, 0]);

  // Handle exceptions
  try {
    await network.get('https://jsonplaceholder.typicode.com/todos/202');
  } on network.NetworkException catch (error) {
    print('Network exception handled: ${error}');
  }
}
