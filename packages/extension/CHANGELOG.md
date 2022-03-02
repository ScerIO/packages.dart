[comment]: <> (Changelog bum example)
[comment]: <> (## version)
[comment]: <> (### Breaking Changes or ### New Features)
[comment]: <> (* Change description)


## 0.4.0

* Replaced multiple imports by one 
```diff
-// Or by entity. Available: string, date, list, enum
-import 'package:extension/<ENTITY NAME>.dart';

+import 'package:extension/extension.dart';
```
* Changed api's: 
```diff
- plural(1, 'дом', 'дома', 'домов');
- pluralize(1, 'дом', 'дома', 'домов');

- DateUtils.isSameWeek(DateTime(2017, 3, 5), DateTime(2017, 3, 6));
+ DateTime(2017, 3, 5).isSameWeek(DateTime(2017, 3, 6));

- DateUtils.isSameDay(DateTime.now(), DateTime.now());
+ DateTime.now().isSameDay(DateTime.now());
```
* Added date utils 
```dart
/// Tomorrow at same hour / minute / second than now
DateUtils.tomorrow;

/// Yesterday at same hour / minute / second than now
DateUtils.yesterday;

/// Current date (Same as [Date.now])
DateUtils.today;

// Returns a [DateTime] with the date of the original
DateTime(2017, 3, 6, 12, 30, 15).dateOnly; // DateTime(2017, 3, 6)

/// The day after this [DateTime]
DateTime(2017, 3, 5).nextDay; // return DateTime(2017, 3, 6)

/// The day previous this [DateTime]
DateTime(2017, 3, 5).previousDay; // return DateTime(2017, 3, 4)
```
* Provide more docs at readme

## 0.3.0

* Added `ListUtils` with thunks splitting
* Added `isTomorrow` in date utils
* Mark `enumValueByString` in enum utils deprecated.
  But [dart add it feature from v2.15](https://api.flutter.dev/flutter/dart-core/EnumName/name.html)

## 0.2.0

* Stable release

## 0.2.0-nullsafety.0

* Added nullsafety [pull#8](https://github.com/rbcprolabs/packages.dart/pull/8)

## 0.1.1

* Fixed `isSameDay` in date utils

## 0.1.0

* Rewrite with extension methods
* Added date with `isToday` & `isYesterday` extension methods
* in `enumValueByString` added `orElse` property
* added `plural` in strings

## 0.0.5

* Added operator `==` to `Enum<T>`

## 0.0.4

* Added string entity with `capitalizeFirstLetter` function
* `enumValueByString` returns null if can't find the value

## 0.0.3

* `enumValueByString` now throws `EnumValueInvalideParamsException` instead simple `Exception`

## 0.0.2

### Breaking Changes

* `enumValueByString` now throws `EnumValueNotFoundException` if can't find the value

## 0.0.1

* Initial commit
