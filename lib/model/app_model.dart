import 'dart:convert';
import 'dart:math';

import 'package:almaty_metro/api/api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AppModel extends ChangeNotifier {
  final api = AlmetroApi();

  Subway subway;
  bool isFetching = false;

  ScheduleType scheduleType = ScheduleType.normal;
  SubwayStation _selectedStation;

  SubwayStation get selectedStation => _selectedStation;
  int get selectedStationIndex => subwayLine.getStationIndex(_selectedStation);
  int get stationsLength => subwayLine.stations.length;

  DateTime _lastFetchTime;
  DateTime get lastFetchTime => _lastFetchTime;

  bool _autoUpdate = false;
  bool get autoUpdate => _autoUpdate;
  set autoUpdate(bool v) {
    _autoUpdate = v;
    SharedPrefs.instance.setBool('auto_update', _autoUpdate);
    notifyListeners();
  }

  set selectedStation(SubwayStation v) {
    _selectedStation = v;
    SharedPrefs.instance.setInt('last_station_id', v.id);
    notifyListeners();
  }

  Brightness _brightness;
  Brightness get brightness => _brightness;
  set brightness(Brightness brightness) {
    _brightness = brightness;
    SharedPrefs.instance.setBool('dark_theme', _brightness == Brightness.dark);
    notifyListeners();
  }

  SubwayLine get subwayLine => subway.schedules[scheduleType].lines[0];

  AppModel() {
    final _darkTheme = SharedPrefs.instance.getBool('dark_theme');

    if (_darkTheme != null) {
      _brightness = _darkTheme ? Brightness.dark : Brightness.light;
    }

    _autoUpdate = SharedPrefs.instance.getBool('auto_update') ?? false;
    if (_autoUpdate) {
      fetchFromNetwork();
    }

    loadFromCache();
  }

  Future<void> fetchFromNetwork() async {
    isFetching = true;
    notifyListeners();

    try {
      final response = await api.downloadSubwayData();
      setSubway(api.getSubwayFromResponse(response));

      SharedPrefs.instance.setString(
        'cached_data',
        jsonEncode(response),
      );

      _lastFetchTime = DateTime.now();
      SharedPrefs.instance.setInt(
        'last_fetch_time',
        _lastFetchTime.millisecondsSinceEpoch,
      );
    } catch (e) {
      print(e);
    }

    isFetching = false;
    notifyListeners();
  }

  Future<void> loadFromCache() async {
    final cache = SharedPrefs.instance.getString('cached_data');
    if (cache == null) {
      return;
    }

    _lastFetchTime = DateTime.fromMillisecondsSinceEpoch(
      SharedPrefs.instance.getInt('last_fetch_time'),
    );

    setSubway(api.getSubwayFromResponse(jsonDecode(cache)));
    notifyListeners();
  }

  void setSubway(Subway subway) {
    this.subway = subway;

    final id = SharedPrefs.instance.getInt('last_station_id');

    _selectedStation =
        id != null ? subwayLine.getStationWithId(id) : subwayLine.stations[0];

    SharedPrefs.instance.setInt('last_station_id', _selectedStation.id);
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
