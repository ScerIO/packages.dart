[comment]: <> (Changelog bum example)
[comment]: <> (## version)
[comment]: <> (### Breaking Changes or ### New Features)
[comment]: <> (* Change description)

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
