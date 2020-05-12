import 'package:extension/enum.dart';

enum AnyEnum {
  one,
  two,
  three,
}

main() {
  final AnyEnum findValue = enumValueByString(AnyEnum.values, 'two');
  print(findValue == AnyEnum.two);

  enumValueByString(AnyEnum.values, 'bed value') ?? print('Im success handled');
}
