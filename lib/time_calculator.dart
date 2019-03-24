import 'dart:math';

Duration getTimeBetweenTwoStations(int firstStation, int lastStation) {
  int distance = (firstStation - lastStation).abs();
  if (distance == 0) {
    return Duration.zero;
  } else if (distance == 1) {
    firstStation = min(firstStation, lastStation);

    if (firstStation == 0) {
      // Moscow - Sairan
      return Duration(minutes: 2, seconds: 20);
    } else if (firstStation == 1) {
      // Sairan - Alatau
      return Duration(minutes: 3, seconds: 40);
    } else if (firstStation == 2) {
      // Alatau - Theater nm. after Mukhtar Auezov
      return Duration(minutes: 2, seconds: 50);
    } else if (firstStation == 3) {
      // Theater nm. after Mukhtar Auezov - Baikonur
      return Duration(minutes: 2, seconds: 20);
    } else if (firstStation == 4) {
      //Baikonur - Abay
      return Duration(minutes: 3, seconds: 10);
    } else if (firstStation == 5) {
      //Abay - Almaly
      return Duration(minutes: 2, seconds: 35);
    } else if (firstStation == 6) {
      //Almaly - Zhybek zholy
      return Duration(minutes: 2, seconds: 10);
    } else if (firstStation == 7) {
      //Zhybek zholy - Raimbek Batyra
      return Duration(minutes: 2, seconds: 25);
    } else {
      throw Exception("Invalid station id.");
    }
  } else {
    int minimum = min(firstStation, lastStation);
    int maximum = max(firstStation, lastStation);

    Duration totalDuration = Duration();

    for (int i = minimum; i < maximum; i++) {
      totalDuration += getTimeBetweenTwoStations(i, i + 1);
    }

    return totalDuration;
  }
}

DateTime getStartTime(int stationIndex) {
  DateTime now = DateTime.now();
  if (stationIndex == 0) {
    return DateTime(now.year, now.month, now.day, 6, 30, 0, 0, 0);
  } else if (stationIndex == 8) {
    return DateTime(now.year, now.month, now.day, 6, 21, 0, 0, 0);
  } else {
    throw Exception("Invalid station id.");
  }
}

class LaunchTimeDiff {
  int count;
  Duration timeBetween;

  LaunchTimeDiff(this.timeBetween, [this.count = 1]);
}

List<LaunchTimeDiff> moscowDiff = [
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30), 2),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 0)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 40)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 50)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30), 2),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 0)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 40)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 50)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30), 2),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 0)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 40)),
  LaunchTimeDiff(Duration(minutes: 7, seconds: 20)),
  LaunchTimeDiff(Duration(minutes: 10, seconds: 0), 2),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 12, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 12, seconds: 0)),
  LaunchTimeDiff(Duration(minutes: 13, seconds: 0), 33),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 35), 6),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 5)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 35), 6),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 5)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 35), 5),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 5)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 35)),
  LaunchTimeDiff(Duration(minutes: 13, seconds: 15)),
  LaunchTimeDiff(Duration(minutes: 13, seconds: 0), 15),
  LaunchTimeDiff(Duration(minutes: 18, seconds: 0)),
];

List<LaunchTimeDiff> rbDiff = [
  LaunchTimeDiff(Duration(minutes: 9, seconds: 0)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 40)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 50)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30), 2),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 0)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 40)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 50)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30), 2),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 0)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 40)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 50)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 10, seconds: 0)),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 12, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 10, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 13, seconds: 0)),
  LaunchTimeDiff(Duration(minutes: 13, seconds: 30)),
  LaunchTimeDiff(Duration(minutes: 13, seconds: 0), 31),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 35), 6),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 5)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 35), 6),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 5)),
  LaunchTimeDiff(Duration(minutes: 8, seconds: 35), 6),
  LaunchTimeDiff(Duration(minutes: 9, seconds: 5)),
  LaunchTimeDiff(Duration(minutes: 13, seconds: 15)),
  LaunchTimeDiff(Duration(minutes: 13, seconds: 0), 17),
  LaunchTimeDiff(Duration(minutes: 18, seconds: 0)),
];

List<DateTime> getLaunchTimes(int stationIndex) {
  DateTime time = getStartTime(stationIndex);
  List<DateTime> result = [time];

  List<LaunchTimeDiff> diffs;
  //Total: 96
  if (stationIndex == 0) {
    diffs = moscowDiff;
  } else if (stationIndex == 8) {
    diffs = rbDiff;
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

List<DateTime> getArrivalTimes(int stationIndex, int directionIndex) {
  int startIndex = directionIndex == 0 ? 8 : 0;
  List<DateTime> launchTimes = getLaunchTimes(startIndex);
  Duration distanceDuration = getTimeBetweenTwoStations(startIndex, stationIndex);
  if (directionIndex == 1) {
    return launchTimes.map((time) => time.add(distanceDuration)).toList();
  } else {
    if (stationIndex < 4) {
      DateTime now = DateTime.now();
      launchTimes.insert(0, DateTime(now.year, now.month, now.day, 6, 25, 10).subtract(distanceDuration));
      return launchTimes.map((time) => time.add(distanceDuration)).toList();
    } else {
      return launchTimes.map((time) => time.add(distanceDuration)).toList();
    }
  }
}
