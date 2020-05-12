import 'package:network/network.dart';
import 'package:network/interceptors.dart';

/// HTTP 404
class MyNotFoundException extends NetworkException {
  MyNotFoundException(Response response) : super(response);
}

main() async {
  NetworkSettings().interceptors.addAll([
    defaultErrors(),
    Interceptor(
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
    final getResponse = await 'https://jsonplaceholder.typicode.com/comments'
        .get(queryParameters: {'postId': 1});
    print('body: ' + getResponse.asList[1]['body']);

    // Post request to api
    final postResponse = await 'https://jsonplaceholder.typicode.com/todos'
        .post(body: {'title': 'test'});
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
  await 'https://jsonplaceholder.typicode.com/todos'
      .post(body: [0, 0, 0, 0, 0]);

  // Handle exceptions
  try {
    await 'https://jsonplaceholder.typicode.com/todos/202'.get();
  } on MyNotFoundException catch (error) {
    print('Network exception handled: ${error}');
  }
}
