import 'package:extension/string.dart';
import 'package:test/test.dart';

main() {
  test('capitalizeFirstLetter', () {
    expect(capitalizeFirstLetter('test'), equals('Test'));
    expect(capitalizeFirstLetter('Test'), equals('Test'));
    expect(capitalizeFirstLetter('TEst'), equals('TEst'));
  });
}
