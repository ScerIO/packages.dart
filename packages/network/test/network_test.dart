import 'package:test/test.dart';
import 'package:network/network.dart';

/// TODO: Make tests
void main() {
  test('get', () async {
    await 'https://jsonplaceholder.typicode.com/todos/1'.get();
  });
}
