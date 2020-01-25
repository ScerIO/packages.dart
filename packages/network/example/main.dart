import 'package:network/hooks.dart' as network;
import 'package:network/interceptors.dart';

/// HTTP 404
class MyNotFoundException extends network.NetworkException {
  MyNotFoundException(network.Response response) : super(response);
}

main() async {
  network.settings
    ..interceptors.addAll([
      defaultErrors(),
      network.Interceptor(
        onRequest: (request) {
          print('\nrequest: ${request.url} \n');
          return request;
        },
        onResponse: (response) {
          print('response status code: ${response.statusCode}');
          return response;
        },
        onError: (error) {
          if (error is NotFoundException) {
            return MyNotFoundException(error.response);
          }

          return error;
        },
      )
    ]);

  try {
    final getResponse = await network.get(
        'https://jsonplaceholder.typicode.com/comments',
        queryParameters: {'postId': 1});
    print('body: ' + getResponse.asList[1]['body']);

    // Post request to api
    final postResponse = await network.post(
        'https://jsonplaceholder.typicode.com/todos',
        body: {'title': 'test'});
    print('id: ' + postResponse.asMap['id']);
  }
  // Detect unavailable internet connection:
  // on SocketException - vm / flutter
  // on http.ClientError - browser
  // {
  // print('No internet connection');
  // }
  catch (error) {}

  // Or post binary
  await network.post('https://jsonplaceholder.typicode.com/todos',
      body: [0, 0, 0, 0, 0]);

  // Handle exceptions
  try {
    await network.get('https://jsonplaceholder.typicode.com/todos/202');
  } on MyNotFoundException catch (error) {
    print('Network exception handled: ${error}');
  }
}
