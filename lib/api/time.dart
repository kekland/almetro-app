import 'package:flutter/material.dart';

class Time {
  final int hour;
  final int minute;
  final int second;

  Time({
    @required this.hour,
    @required this.minute,
    @required this.second,
  });

  factory Time.parse(String time) {
    final fragments = time.split(':');
    return Time(
      hour: int.parse(fragments[0]),
      minute: int.parse(fragments[1]),
      second: int.parse(fragments[2]),
    );
  }

  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);

  DateTime get dateTime {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute, second);
  }

  Time clone() => Time(hour: hour, minute: minute, second: second);

  bool operator >(Time other) => this.hashCode > other.hashCode;

  bool operator <(Time other) => this.hashCode < other.hashCode;

  bool operator ==(dynamic other) =>
      other is Time && this.hashCode == other.hashCode;

  @override
  int get hashCode {
    return (hour * 60 * 60) + (minute * 60) + second;
  }

  @override
  String toString() {
    final _hour = hour.toString().padLeft(2, '0');
    final _minute = minute.toString().padLeft(2, '0');
    final _second = second.toString().padLeft(2, '0');

    return '$_hour:$_minute:$_second';
  }

  Time add(Duration duration) {
    final inSeconds = duration.inSeconds;
    final seconds = inSeconds % 60;
    final inMinutes = inSeconds ~/ 60;
    final minutes = inMinutes % 60;
    final hours = inMinutes ~/ 60;

    return Time(
      hour: hour + hours,
      minute: minute + minutes,
      second: second + seconds,
    );
  }

  factory Time.now() {
    final now = DateTime.now();
    return Time(
      hour: now.hour,
      minute: now.minute,
      second: now.second,
    );
  }

  Duration difference(Time t2) {
    return Duration(seconds: t2.hashCode - hashCode);
  }
}
