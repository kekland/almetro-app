import 'dart:math';

import 'package:almaty_metro/api/launch_times.dart';

class MetroMath {
  static Duration getTimeBetweenTwoStations({int from, int to}) {
    int distance = (from - to).abs();
    if (distance == 0) {
      return Duration.zero;
    } else if (distance == 1) {
      from = min(from, to);

      if (from == 0) {
        // Moscow - Sairan
        return Duration(minutes: 2, seconds: 20);
      } else if (from == 1) {
        // Sairan - Alatau
        return Duration(minutes: 3, seconds: 40);
      } else if (from == 2) {
        // Alatau - Theater nm. after Mukhtar Auezov
        return Duration(minutes: 2, seconds: 50);
      } else if (from == 3) {
        // Theater nm. after Mukhtar Auezov - Baikonur
        return Duration(minutes: 2, seconds: 20);
      } else if (from == 4) {
        //Baikonur - Abay
        return Duration(minutes: 3, seconds: 10);
      } else if (from == 5) {
        //Abay - Almaly
        return Duration(minutes: 2, seconds: 35);
      } else if (from == 6) {
        //Almaly - Zhybek zholy
        return Duration(minutes: 2, seconds: 10);
      } else if (from == 7) {
        //Zhybek zholy - Raimbek Batyra
        return Duration(minutes: 2, seconds: 25);
      } else {
        throw Exception("Invalid station id.");
      }
    } else {
      int minimum = min(from, to);
      int maximum = max(from, to);

      Duration totalDuration = Duration();

      for (int i = minimum; i < maximum; i++) {
        totalDuration += getTimeBetweenTwoStations(from: i, to: i + 1);
      }

      return totalDuration;
    }
  }

  static DateTime getStartTime({int station}) {
    DateTime now = DateTime.now();
    if (station == 0) {
      return DateTime(now.year, now.month, now.day, 6, 30, 0, 0, 0);
    } else if (station == 8) {
      return DateTime(now.year, now.month, now.day, 6, 21, 0, 0, 0);
    } else {
      throw Exception("Invalid station id.");
    }
  }

  static List<DateTime> getLaunchTimes({int station}) {
    DateTime time = getStartTime(station: station);
    List<DateTime> result = [time];

    List<LaunchTimeDiff> diffs;
    //Total: 96
    if (station == 0) {
      diffs = LaunchTimes.moscowDiff;
    } else if (station == 8) {
      diffs = LaunchTimes.rayimbekBatyraDiff;
    } else {
      throw Exception('Invalid station id.');
    }

    for (var diff in diffs) {
      for (int i = 0; i < diff.count; i++) {
        time = time.add(diff.timeBetween);
        result.add(time);
      }
    }

    return result;
  }

  static List<DateTime> getArrivalTimes({int station, int direction}) {
    int startIndex = direction == 0 ? 8 : 0;
    List<DateTime> launchTimes = getLaunchTimes(station: startIndex);
    Duration distanceDuration = getTimeBetweenTwoStations(from: startIndex, to: station);
    if (direction == 1) {
      return launchTimes.map((time) => time.add(distanceDuration)).toList();
    } else {
      if (station < 4) {
        DateTime now = DateTime.now();
        launchTimes.insert(0, DateTime(now.year, now.month, now.day, 6, 25, 10).subtract(distanceDuration));
        return launchTimes.map((time) => time.add(distanceDuration)).toList();
      } else {
        return launchTimes.map((time) => time.add(distanceDuration)).toList();
      }
    }
  }

  static List<DateTime> getArrivalTimesBetweenStations({int from, int to}) {
    return getArrivalTimes(station: from, direction: getDirection(from: from, to: to));
  }

  static int getDirection({int from, int to}) {
    if (to > from) {
      return 1;
    } else {
      return 0;
    }
  }

  static DateTime getClosestArrivalTimeInList({List<DateTime> arrivalTimes}) {
    DateTime now = DateTime.now();
    for (var time in arrivalTimes) {
      if (now.isBefore(time)) {
        return time;
      }
    }
    return null;
  }
  
  static int getClosestArrivalTimeIndexInList({List<DateTime> arrivalTimes}) {
    DateTime closest = getClosestArrivalTimeInList(arrivalTimes: arrivalTimes);
    if(closest == null) return null;
    return arrivalTimes.indexOf(closest);
  }
}
