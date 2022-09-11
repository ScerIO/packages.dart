import 'package:extension/src/num.dart';
import 'package:meta/meta.dart';

/// The number of milliseconds in an hour.
const _millisecondsPerHour = 3600000;

/// The number of milliseconds in a minute.
const _millisecondsPerMinute = 60000;

/// THe number of milliseconds in a second.
const _millisecondsPerSecond = 1000;

/// The number of microseconds in an hour.
const _microsecondsPerHour = 3600000000;

/// The number of microseconds in a minute.
const _microsecondsPerMinute = 60000000;

/// The number of microseconds in a second.
const _microsecondsPerSecond = 1000000;

/// The number of microseconds in a millisecond.
const _microsecondsPerMillisecond = 1000;

/// The maximum number of microseconds in a day.
const _maxMicroseconds = 86399999999;

/// A `Time` represents the time independent of whether it is in the UTC or local
/// timezone.
@immutable
class Time implements Comparable<Time> {
  /// The start of the day (12 am).
  static const min = Time(0);

  /// THe middle of the day (12 pm).
  static const noon = Time(12);

  /// The end of the day (11:59:59:999:999 pm).
  static const max = Time(23, 59, 59, 999, 999);

  /// The hour.
  final int hour;

  /// The minute.
  final int minute;

  /// The second.
  final int second;

  /// The millisecond.
  final int millisecond;

  /// THe microsecond.
  final int microsecond;

  /// Creates a `Time` with the given time.
  @literal
  const Time(
    this.hour, [
    this.minute = 0,
    this.second = 0,
    this.millisecond = 0,
    this.microsecond = 0,
  ])  : assert(hour >= 0 && hour < 24,
            'Invalid hour: $hour, hour must be between 0 and 23'),
        assert(minute >= 0 && minute < 60,
            'Invalid minute: $minute, minute must be between 0 and 59'),
        assert(second >= 0 && second < 60,
            'Invalid second: $second, second must be between 0 and 59'),
        assert(millisecond >= 0 && millisecond < 1000,
            'Invalid millisecond: $millisecond, millisecond must be between 0 and 999'),
        assert(microsecond >= 0 && microsecond < 1000,
            'Invalid microsecond: $microsecond, microsecond must be between 0 and 999');

  /// Adds the given [duration] to this time. A [RangeError] is thrown if the resultant
  /// time is less than [min] or greater than [max].
  Time operator +(Duration duration) => _adjust(duration, inverse: false);

  /// Subtracts the given [duration] from this time. A [RangeError] is thrown if the resultant
  /// time is less than [min] or greater than [max].
  Time operator -(Duration duration) => _adjust(duration, inverse: true);

  Time _adjust(Duration duration, {required bool inverse}) {
    var value = inMicroseconds +
        (inverse ? -duration.inMicroseconds : duration.inMicroseconds);

    if (value.outside(0, _maxMicroseconds)) {
      throw RangeError(
          'Invalid resultant time: $value, time must be between 0 and 23:59:999:999');
    }

    final microseconds = value % 1000;

    value ~/= 1000;
    final milliseconds = value % 1000;

    value ~/= 1000;
    final seconds = value % 60;

    value ~/= 60;
    final minutes = value % 60;

    value ~/= 60;
    final hours = value % 60;

    return Time(
      hours,
      minutes,
      seconds,
      milliseconds,
      microseconds,
    );
  }

  /// Returns the difference between this and [other].
  Duration difference(Time other) =>
      Duration(microseconds: inMicroseconds - other.inMicroseconds);

  /// Returns `true` if `this` is before [other] and `false` otherwise.
  bool operator <(Time other) => compareTo(other) < 0;

  /// Returns `true` if `this` is before or the same as [other] and `false` otherwise.
  bool operator <=(Time other) => compareTo(other) <= 0;

  @override
  bool operator ==(Object other) => other is Time && compareTo(other) == 0;

  /// Returns `true` if `this` is after or the same as [other] and `false` otherwise.
  bool operator >=(Time other) => compareTo(other) >= 0;

  /// Returns `true` if `this` is after [other] and `false` otherwise.
  bool operator >(Time other) => compareTo(other) > 0;

  @override
  int compareTo(Time other) {
    var result = hour.compareTo(other.hour);
    if (result != 0) {
      return result;
    }

    result = minute.compareTo(other.minute);
    if (result != 0) {
      return result;
    }

    result = second.compareTo(other.second);
    if (result != 0) {
      return result;
    }

    result = millisecond.compareTo(other.millisecond);
    if (result != 0) {
      return result;
    }

    result = microsecond.compareTo(other.microsecond);
    if (result != 0) {
      return result;
    }

    return 0;
  }

  @override
  int get hashCode => inMicroseconds;

  /// Returns `this` in milliseconds.
  int get inMilliseconds {
    var milliseconds = hour * _millisecondsPerHour;
    milliseconds += minute * _millisecondsPerMinute;
    milliseconds += second * _millisecondsPerSecond;
    milliseconds += millisecond;
    return milliseconds;
  }

  /// Returns `this` in microseconds.
  int get inMicroseconds {
    var microseconds = hour * _microsecondsPerHour;
    microseconds += minute * _microsecondsPerMinute;
    microseconds += second * _microsecondsPerSecond;
    microseconds += millisecond * _microsecondsPerMillisecond;
    microseconds += microsecond;
    return microseconds;
  }

  @override
  String toString() =>
      '${hour.padLeft(2)}:${minute.padLeft(2)}:${second.padLeft(2)}.${(millisecond * 1000 + microsecond).padLeft(6)}';
}
