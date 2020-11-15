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
  bool isFetching = false;

  ScheduleType scheduleType = ScheduleType.normal;
  SubwayStation _selectedStation;

  SubwayStation get selectedStation => _selectedStation;

  set selectedStation(SubwayStation station) {
    _selectedStation = station;
    settings.lastStationId = station.id;
    notifyListeners();
  }

  int get selectedStationIndex => subwayLine.getStationIndex(_selectedStation);
  int get stationsLength => subwayLine.stations.length;

  SubwayLine get subwayLine => subway.schedules[scheduleType].lines[0];

  AppModel() {
    settings.addListener(notifyListeners);
    initialFetch();
  }

  Future<void> initialFetch() async {
    await loadFromCache();

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

  Future<void> loadFromCache() async {
    final cache = settings.cachedData;
    if (cache == null) {
      return;
    }

    setSubway(api.getSubwayFromResponse(jsonDecode(cache)));
    notifyListeners();
  }

  void setSubway(Subway subway) {
    this.subway = subway;

    final id = settings.lastStationId;

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
