import 'package:extension/extension.dart';

class Meter<int> extends Enum<int> {
  const Meter(int val) : super(val);

  static const Meter HIGH = const Meter(100);
  static const Meter MIDDLE = const Meter(50);
  static const Meter LOW = const Meter(10);
}

void main() {
  /* String */

  // Capitalize first letter
  'test'.capitalizeFirstLetter(); // return Test

  // Check is email
  'user@example.com'.isEmail; // return true
  'qwerty'.isEmail; // return false

  // Plural forms for russian words
  plural(1, 'дом', 'дома', 'домов'); // returns дом
  plural(2, 'дом', 'дома', 'домов'); // returns дома
  plural(5, 'дом', 'дома', 'домов'); // returns домов

  /* Date */

  // Is today
  DateTime.now().isToday; // return bool

  // Is yesterday
  DateTime.now().isYesterday; // return bool

  // First day of month
  DateTime(2018, 9, 30).firstDayOfMonth; // returns DateTime(2018, 9, 1)

  // Last day of month
  DateTime(2017, 3).lastDayOfMonth; // DateTime(2017, 3, 31)

  // All days in month, DateTime array
  DateTime(2017, 3)
      .daysInMonth; // [DateTime(2017, 3, 1), DateTime(2017, 3, 2), ...]

  assert(DateUtils.isSameWeek(DateTime(2017, 3, 5), DateTime(2017, 3, 6)));

  /* List */

  // Split list by chunks
  [1, 2, 3, 4, 5, 6, 7, 8, 9].chunks(2);
  // => [[1, 2], [3, 4], [5, 6], [7, 8], [9]]

  /* Enum */

  // Enum with value
  assert(Meter.HIGH == 100);
  assert(Meter.HIGH is Meter);
}
