import 'package:extension/enum.dart';
import 'package:test/test.dart';

enum _TestNormal {
  one,
  two,
  one1,
}

main() {
  group('Enum value by string', () {
    test('Base', () {
      final one = enumValueByString(_TestNormal.values, 'one');
      expect(one, allOf([
        equals(_TestNormal.one),
        isNot(equals(_TestNormal.two)),
        isNot(equals(_TestNormal.one1)),
      ]));
    });

    test('Case intensive', () {
      final caseIntensive = enumValueByString(_TestNormal.values, 'OnE');
      expect(caseIntensive, allOf([
        equals(_TestNormal.one),
        isNot(equals(_TestNormal.two)),
        isNot(equals(_TestNormal.one1)),
      ]));
    });

    test('Not exist', () {
      final three = enumValueByString(_TestNormal.values, 'three');
      expect(three, isNull);
    });

    test('Enum name in value', () {
      final name = enumValueByString(_TestNormal.values, 'normal');
      expect(name, isNull);
    });
  });
}
