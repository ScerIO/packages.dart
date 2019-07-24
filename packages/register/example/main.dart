import 'package:register/register.dart';

void main() {
  final register = Register('how_now_brown_cow');
  print(register); // => howNowBrownCow
  print(register.snake); // => how_now_brown_cow
  print(register.emacs); // => how-now-brown-cow
  print(register.shout); // => HOW_NOW_BROWN_COW
  print(register.camel); // => howNowBrownCow
  print(register.capCamel); // => HowNowBrownCow
  print(register.title); // => How Now Brown Cow
  print(register.squish); // => hownowbrowncow
  print(register.abbrev); // => hnbc
}
