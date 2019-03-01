import 'package:extension/enum.dart';

enum AnyEnum {
  one,
  two,
  three,
}

main() {
  final AnyEnum findedvalue = enumValueByString(AnyEnum.values, 'two');
  print(findedvalue == AnyEnum.two);

  try {
    enumValueByString(AnyEnum.values, 'bed value');
  } on EnumValueNotFoundException {
    print('Im successfuly handled');
  }
}
