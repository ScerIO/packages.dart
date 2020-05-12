import 'package:extension/string.dart';
import 'package:test/test.dart';

main() {
  test('capitalizeFirstLetter', () {
    expect('test'.capitalizeFirstLetter(), equals('Test'));
    expect('Test'.capitalizeFirstLetter(), equals('Test'));
    expect('TEst'.capitalizeFirstLetter(), equals('TEst'));
  });
}
