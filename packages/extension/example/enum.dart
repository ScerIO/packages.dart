import 'package:extension/enum.dart';

enum AnyEnum {
  one,
  two,
  three,
}

main() {
  final AnyEnum findedvalue = enumValueByString(AnyEnum.values, 'two');
  print(findedvalue == AnyEnum.two);

  enumValueByString(AnyEnum.values, 'bed value') ??
      print('Im successfuly handled');
}
