import 'package:extension/date.dart';
import 'package:test/test.dart';

void main() {
  group('Utils Tests', () {
    test('firstDayInMonth Sept 30 2018', () {
      var lastDay = DateTime(2018, 9, 30).firstDayOfMonth;
      var expected = DateTime(2018, 9, 1);
      expect(lastDay, expected);
    });

    test('lastDayInMonth', () {
      var lastDay = DateTime(2017, 3).lastDayOfMonth;
      var expected = DateTime(2017, 3, 31);
      expect(lastDay, expected);
    });

    test('daysInMonth', () {
      var days = DateTime(2017, 3).daysInMonth;
      expect(days, hasLength(35));
    });

    test('daysInMonthWithTimeChangeFallBack', () {
      var days = DateTime(2017, 11).daysInMonth;
      expect(days, hasLength(35));
    });

    test('daysInMonthWithTimeChangeSpringForward', () {
      var days = DateTime(2018, 4).daysInMonth;
      expect(days, hasLength(42));
    });

    group('daysInMonth', () {
      void _assertDaysInMonth(
        DateTime date, {
        required DateTime first,
        required DateTime last,
        required int length,
      }) {
        var days = date.daysInMonth;
        expect(days.first, first);
        expect(days.last, last);
        expect(days.length, length);
      }

      test('9 30 2018', () {
        _assertDaysInMonth(
          DateTime(2018, 9, 30),
          first: DateTime(2018, 8, 26),
          last: DateTime(2018, 10, 6),
          length: 42,
        );
      });
      test('8 30 2018', () {
        _assertDaysInMonth(
          DateTime(2018, 8, 8),
          first: DateTime(2018, 7, 29),
          last: DateTime(2018, 9, 1),
          length: 35,
        );
      });
    });

    test('isSameWeek', () {
      expect(DateUtils.isSameWeek(DateTime(2017, 3, 4), DateTime(2017, 3, 5)),
          false);
      expect(DateUtils.isSameWeek(DateTime(2017, 3, 5), DateTime(2017, 3, 6)),
          true);
      expect(DateUtils.isSameWeek(DateTime(2017, 2, 26), DateTime(2017, 3, 4)),
          true);
      expect(DateUtils.isSameWeek(DateTime(2017, 3, 4), DateTime(2017, 3, 10)),
          false);
      expect(DateUtils.isSameWeek(DateTime(2017, 3, 3), DateTime(2017, 3, 10)),
          false);
      expect(DateUtils.isSameWeek(DateTime(2017, 3, 10), DateTime(2017, 3, 10)),
          true);
      expect(
          DateUtils.isSameWeek(
              DateTime(2018, 3, 29, 12), DateTime(2018, 3, 22, 12)),
          false);
      expect(
          DateUtils.isSameWeek(
              DateTime(2018, 3, 6, 12), DateTime(2018, 3, 13, 12)),
          false);
    });

    List<DateTime> testDates = [];
    late DateTime today;

    setUp(() {
      today = DateTime.now();
      // A full Calendar Week
      testDates
        ..add(DateTime(2018, 3, 4))
        ..add(DateTime(2018, 3, 5))
        ..add(DateTime(2018, 3, 6))
        ..add(DateTime(2018, 3, 7))
        ..add(DateTime(2018, 3, 8))
        ..add(DateTime(2018, 3, 9))
        ..add(DateTime(2018, 3, 10));
    });

    for (var i = 0; i < 7; i++) {
      test('Utils.firstDayOfWeek', () {
        expect(testDates[i].firstDayOfWeek.day, testDates[0].day);
      });
    }

    for (var i = 0; i < 7; i++) {
      test('Utils.lastDayOfWeek', () {
        expect(testDates[i].lastDayOfWeek.day,
            testDates[6].add(Duration(days: 1)).day);
      });
    }

    // Test 100 Days for the right length
    for (var i = 0; i < 100; i++) {
      test('datesInRange()', () {
        var date = DateTime.now();
        date.add(Duration(days: i));

        var firstDayOfCurrentWeek = today.firstDayOfWeek;
        var lastDayOfCurrentWeek = today.lastDayOfWeek;

        expect(
            DateUtils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
                .toList()
                .length,
            7);
      });
    }
  });
}
