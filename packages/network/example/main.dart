import 'package:network/network.dart' as network;

main() async {
  final getResponse = await network.get<network.JsonApiResponse>(
      'https://jsonplaceholder.typicode.com/comments', queryParameters: {
        'postId': 1
      });
  print(getResponse.toList[1]['body']);

  // Post request to api
  final postResponse = await network.post<network.JsonApiResponse>(
      'https://jsonplaceholder.typicode.com/todos',
      body: {'title': 'test'});
  print(postResponse.toMap['id']);

  // Or post binary
  // await network.post<network.JsonApiResponse>(
  //   'https://jsonplaceholder.typicode.com/todos', body: [0,0,0,0,0],
  // jsonBody: false);

  /// Handle exceptions
  try {
    await network.get('https://jsonplaceholder.typicode.com/todos/202');
  } on network.NetworkException catch (error) {
    print('Network exception called, status code: ${error.code}');
  }
}
