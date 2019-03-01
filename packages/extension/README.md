# Extension

Expansion dart language features

## Getting Started

Import
```dart
import 'package:extension/<ENTITY NAME>.dart'
``` 

For example expansion enum:
```dart
import 'package:extension/enum.dart'

// After you can usage additional functions
final one = enumValueByString(AnyEnum.values, 'one') // Returns AnyEnum.one
``` 