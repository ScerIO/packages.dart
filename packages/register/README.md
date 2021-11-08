<img src="https://raw.githubusercontent.com/rbcprolabs/packages.dart/master/packages/register/media/hero.png" alt="Logo" width="100%" />

<p align="center">Package for consistently representing identifiers, usually in a code generation setting.</p>

<p align="center">
  <a href="https://pub.dartlang.org/packages/register">
    <img src="https://img.shields.io/pub/v/register.svg"
         alt="Pub">
  </a>
</p>

<p align="center">
  <a href="#purpose">Purpose</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#credits">Credits</a>
</p>

## Purpose

The purpose of the library is to have a standard way of generating an object, an Id, that can be used in any of a variety of casing contexts.

## Getting Started

For example, suppose you are writing a code generator that has a need for a single id with multiple representations. The following representations are covered:

* snake case: words are all lower case with underscores (how_now_brown_cow)
* emacs: words are all lower with hyphens (how-now-brown-cow)
* shout: words are all upper case with underscores (HOW_NOW_BROWN_COW)
* camel: words are joined with each word capitalized excluding the first (howNowBrownCow)
* capCamel: words are joined with all words capitalized (HowNowBrownCow)
* title: All words capitalized and joined with spaces (How Now Brown Cow)
* squish: Lower case with no hypens or underscores (hownowbrowncow)
* abbrev: The abbreviation in lower case (hnbc)

The default constructor requires the identifier to be snake case:
```dart
final id = Register('how_now_brown_cow');

print(id);                   // => howNowBrownCow        
print(id.snake);             // => how_now_brown_cow     
print(id.emacs);             // => how-now-brown-cow     
print(id.shout);             // => HOW_NOW_BROWN_COW     
print(id.camel);             // => howNowBrownCow        
print(id.capCamel);          // => HowNowBrownCow        
print(id.title);             // => How Now Brown Cow     
print(id.squish);            // => hownowbrowncow        
print(id.abbrev);            // => hnbc                  
```

An library function accepts either snake or any camel and returns a new Id:

```dart
var id = idFromString('testName');
```

And... api reference [available here](https://pub.dartlang.org/documentation/register/latest/)

## Credits
This software is cloning package incompatible with Dart 2:
* [id](https://github.com/patefacio/id)
