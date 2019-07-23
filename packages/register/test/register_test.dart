import 'package:register/register.dart';
import 'package:test/test.dart';

void main() {
  final TypeMatcher<ArgumentError> thrownItem = isA<ArgumentError>();

  void _common(Register tn) {
    expect(tn.id, 'test_name');

    expect(tn.abbrev, 'tn');
    expect(tn.camel, 'testName');
    expect(tn.capCamel, 'TestName');
    expect(tn.emacs, 'test-name');
    expect(tn.sentence, 'test name');
    expect(tn.shout, 'TEST_NAME');
    expect(tn.snake, 'test_name');
    expect(tn.squish, 'testname');
    expect(tn.title, 'Test Name');
  }

  group('basics', () {
    test('default creation (snake)', () {
      _common(Register('test_name'));
      expect(() => Register('test name'), throwsA(thrownItem));
      expect(() => Register('testName'), throwsA(thrownItem));
    });

    test('creation from camels', () {
      _common(Register.fromCamels('testName'));
      _common(Register.fromCamels('TestName'));
      expect(() => Register.fromCamels('test name'), throwsA(thrownItem));
      expect(() => Register.fromCamels('test_name'), throwsA(thrownItem));
    });

    test('creation from idFromString/idFromWords', () {
      _common(idFromString('testName'));
      _common(idFromString('test_name'));
      _common(idFromString('TestName'));
      expect(idFromString('FOOBAR').snake, 'foobar');
      expect(idFromString('FOO_BAR').snake, 'foo_bar');
      expect(idFromWords('this is a test').snake, 'this_is_a_test');
      expect(idFromWords(' this   is a test  ').snake, 'this_is_a_test');
      expect(idFromWords('this is a test').snake, 'this_is_a_test');
      expect(idFromWords('THIS   IS A TEST  ').snake, 'this_is_a_test');
    });

    group('words starting with number', () {
      test('allowed in Register ctor', () {
        expect(Register('a_1').toString(), 'a1');
        expect(idFromString('A_1_a_a').snake, 'a_1_a_a');
      });

      test('not allowed in idFromString', () {
        expect(() => idFromString('a__'), throwsA(ArgumentError));
        expect(() => idFromString('A__'), throwsA(ArgumentError));
        expect(() => idFromString('A_1_'), throwsA(ArgumentError));
        expect(() => idFromString('A_1_a_A'), throwsA(ArgumentError));
      });
    });

    test('isCamel identification', () {
      expect(Register.isCamel('ThisIsCamel'), true);
      expect(Register.isCamel('thisIsCamel'), true);
      expect(Register.isCamel('this_Is_Not_Camel'), false);
      expect(Register.isCamel('thisIsNot Camel'), false);
      expect(Register.isCapCamel('ThisIsCapCamel'), true);
      expect(Register.isCapCamel('thisIsNotCapCamel'), false);
      expect(Register.isSnake('this_is_snake'), true);
      expect(Register.isSnake('this_is_not_Snake'), false);
      expect(Register.isSnake('this_1_is_snake'), true);
      expect(Register.isSnake('this1_is_nake'), true);

      expect(Register.isCamel('This1isCamel'), true);
      expect(Register.isCamel('3ThisisCamel'), false);
    });

    test('capitalize/uncapitalize', () {
      expect(Register.capitalize('this is a test'), 'This is a test');
      expect(Register.uncapitalize('This is a test'), 'this is a test');
      expect(Register.capitalize(' oops'), ' oops');
      expect(Register.uncapitalize(' oops'), ' oops');
    });

    test('==', () {
      expect(Register('one_two_three'), idFromString('oneTwoThree'));
      expect(Register('one_two_three') != idFromString('threeTwoOne'), true);
    });

    test('json', () {
      final Register id = Register('how_now_brown_cow');
      expect(id, Register.fromJson(id.toJson()));
    });

    test('capSubstringToCamel', () {
      expect(capSubstringToCamel('shouldFixABC'), 'shouldFixAbc');
      expect(capSubstringToCamel('ABCDE'), 'Abcde');
      expect(capSubstringToCamel('ABCDEFoobar'), 'AbcdeFoobar');
      expect(capSubstringToCamel('gooFOOMoo'), 'gooFooMoo');
      expect(capSubstringToCamel('CIASpy'), 'CiaSpy');
    });

    test('RegisterTrailingUnderscore', () {
      RegisterTrailingUnderscore makeRegister(id) =>
          RegisterTrailingUnderscore(id);
      expect(makeRegister('simple_test').capCamel, 'SimpleTest_');
      expect(makeRegister('simple_test').camel, 'simpleTest_');
      expect(makeRegister('simple_test').snake, 'simple_test_');
      expect(makeRegister('simple_test').capSnake, 'Simple_test_');
      expect(makeRegister('simple_test').emacs, 'simple-test-');

      expect(idTrailingUnderscore('simple_test').emacs, 'simple-test-');
    });
  });
}
