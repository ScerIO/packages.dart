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
  network.NetworkSettings().exceptionDelegate = (error) {
    // You can check type of respose in error by:
    // if (error is network.JsonApiResponse)

    if (error is network.NetworkException) {
      switch (error.code) {
        case 400:
          throw BadRequestException(error.response);
        case 404:
          throw NotFoundException(error.response);
        default:
          throw error;
      }
    } else if (error is network.NetworkUnavailableException) {
      throw NoInternetConnection();
    }

    throw error;
  };

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
    print('No intrernet connection');
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
