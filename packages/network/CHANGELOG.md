[comment]: <> (Changelog bum example)
[comment]: <> (## version)
[comment]: <> (### Breaking Changes or ### New Features)
[comment]: <> (* Change description)

## 0.7.1

* Fix defaul headers

## 0.7.0 

* Added property to use an external http-client

## 0.6.0

* Added `userAgent` (available in Settings)
* Added `defaultHeaders` (available in Settings)
* Added default http exceptions (like a unautchorized, not found etc)

## 0.5.0 

* Refactoring

## 0.4.0

* Added `NetworkUnavailableException`
* Fixed `exceptionDelegate`

## 0.3.0

* Added `NetworkSettings`
* Added `exceptionDelegate` in `NetworkSettings`

## 0.2.0

* Added `toString()` method for `NetworkException` and `BinaryResponse`
* Added `toJsonApiResponse()` method for `BinaryResponse`

## 0.1.0

* Added parameter `queryParameters` for all methods
* Removed parameter `jsonBody` from *post* and *put* methods

## 0.0.2

* Removed debug print
* Added hooks for `delete` & `put` http methods

## 0.0.1

* Initial release
