import 'dart:convert';
import 'dart:math';

import 'package:almaty_metro/api/api.dart';
import 'package:almaty_metro/model/settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AppModel extends ChangeNotifier {
  final api = AlmetroApi();
  final settings = AppSettings();

  Subway subway;
  bool isFetching = true;

  String _currentHoliday;
  ScheduleType _scheduleType = ScheduleType.normal;

  SubwayStation _selectedStation;

  SubwayStation get selectedStation => _selectedStation;
  String get currentHoliday => _currentHoliday;

  bool get isHoliday => _scheduleType == ScheduleType.holiday;

  set selectedStation(SubwayStation station) {
    _selectedStation = station;
    settings.lastStationId = station.id;
    notifyListeners();
  }

  int get selectedStationIndex => subwayLine.getStationIndex(_selectedStation);
  int get stationsLength => subwayLine.stations.length;

  SubwayLine get subwayLine => subway.schedules[_scheduleType].lines[0];

  ScheduleType get scheduleType => _scheduleType;
  set scheduleType(ScheduleType type) {
    _scheduleType = type;
    selectedStation = subwayLine.getStationWithId(_selectedStation.id);

    notifyListeners();
  }

  AppModel() {
    settings.addListener(notifyListeners);
    initialFetch();
  }

  Future<void> initialFetch() async {
    await loadFromCache(false);

    if (subway != null) notifyListeners();

    if (subway == null || settings.autoUpdate) {
      await fetchFromNetwork();
    }
  }

  Future<void> fetchFromNetwork() async {
    isFetching = true;
    notifyListeners();

    try {
      final response = await api.downloadSubwayData();

      setSubway(api.getSubwayFromResponse(response));

      settings.cachedData = json.encode(response);
      settings.lastFetchTime = DateTime.now();
    } catch (e) {
      print(e);
    }

    isFetching = false;
    notifyListeners();
  }

  Future<void> loadFromCache([bool notify = true]) async {
    final cache = settings.cachedData;
    
    if (cache == null) {
      return;
    }

    setSubway(api.getSubwayFromResponse(jsonDecode(cache)));

    if (notify) {
      notifyListeners();
    }
  }

  void setSubway(Subway subway) {
    this.subway = subway;

    final id = settings.lastStationId;

    final now = DateTime.now();
    final holiday = subway.holidays.firstWhere(
      (v) {
        final time = v.item1;
        return now.day == time.day &&
            now.month == time.month &&
            now.year == time.year;
      },
      orElse: () => null,
    );

    if (holiday != null) {
      _scheduleType = ScheduleType.holiday;
      _currentHoliday = holiday.item2;
    } else if (now.weekday >= DateTime.saturday) {
      _scheduleType = ScheduleType.holiday;
    } else {
      _scheduleType = ScheduleType.normal;
    }

    _selectedStation =
        id != null ? subwayLine.getStationWithId(id) : subwayLine.stations[0];

    settings.lastStationId = id;
  }

  SubwayStation getClosestStation(Position position) {
    final distances = subwayLine.stations
        .map(
          (v) => Geolocator.distanceBetween(
            v.latitude,
            v.longitude,
            position.latitude,
            position.longitude,
          ),
        )
        .toList();

    final minDistance = distances.reduce(min);
    return subwayLine.stations[distances.indexOf(minDistance)];
  }
}
