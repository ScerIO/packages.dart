<img src="https://raw.githubusercontent.com/rbcprolabs/packages.dart/master/packages/extension/media/hero.png" alt="Logo" width="100%" />

<p align="center">Package including lot helpers for easy developing on <a href="https://www.dartlang.org/" target="_blank">dart</a> language.</p>

<p align="center">
  <a href="https://pub.dev/packages/extension">
    <img src="https://img.shields.io/pub/v/extension.svg"
         alt="Pub">
  </a>
</p>

<p align="center">
  <a href="#key-features">Key Features</a> •
  <a href="#getting-started">Getting Started</a>
</p>

## Key Features

* Small weight
* Simple usage
* Many entities

## Getting Started

Import
```dart
import 'package:extension/extension.dart';
``` 

### String

```dart
// Capitalize first letter
'test'.capitalizeFirstLetter(); // return Test

// Check is email
'user@example.com'.isEmail; // return true
'qwerty'.isEmail; // return false

// Pluralize and singularize
pluralize(1, 'дом', 'дома', 'домов'); // returns дом
pluralize(2, 'дом', 'дома', 'домов'); // returns дома
pluralize(5, 'дом', 'дома', 'домов'); // returns домов
```

### Date

```dart
// Returns a [DateTime] with the date of the original
DateTime(2017, 3, 6, 12, 30, 15).dateOnly; // DateTime(2017, 3, 6)

// Is today
DateTime.now().isToday; // return bool

// Is yesterday
DateTime.now().isYesterday; // return bool

// Is yesterday
DateTime.now().isTomorrow; // return bool

/// The day after this [DateTime]
DateTime(2017, 3, 5).nextDay; // return DateTime(2017, 3, 6)

/// The day previous this [DateTime]
DateTime(2017, 3, 5).previousDay; // return DateTime(2017, 3, 4)

// First day of month
DateTime(2018, 9, 30).firstDayOfMonth; // returns DateTime(2018, 9, 1)

// Last day of month
DateTime(2017, 3).lastDayOfMonth; // DateTime(2017, 3, 31)

// All days in month, DateTime array
DateTime(2017, 3).daysInMonth; // [DateTime(2017, 3, 1), DateTime(2017, 3, 2), ...]

// Whether or not two times are on the same day.
DateTime.now().isSameDay(DateTime.now()); // returns true

// Whether or not two times are on the same week.
DateTime(2017, 3, 5).isSameWeek(DateTime(2017, 3, 6));

/// Tomorrow at same hour / minute / second than now
DateUtils.tomorrow;

/// Yesterday at same hour / minute / second than now
DateUtils.yesterday;

/// Current date (Same as [Date.now])
DateUtils.today;

// Returns a [DateTime] for each day the given range.
DateUtils.daysInRange(startDate, endDate); // List of dates

/// Other methods
date.firstDayOfWeek;
date.lastDayOfWeek;
date.previousMonth;
date.nextMonth;
date.previousWeek;
date.nextWeek;
```

And... all api reference [available here](https://pub.dev/documentation/extension/latest/)

