import 'package:extension/string.dart';

main() {
  final capitalized =
      'capitalize my first letter, please!'.capitalizeFirstLetter();
  assert(capitalized == 'Capitalize my first letter, please!');
}
