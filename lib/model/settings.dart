import 'package:almaty_metro/api/api.dart';
import 'package:flutter/material.dart';

const KEY_LAST_FETCH_TIME = 'last_fetch_time';
const KEY_LAST_STATION_ID = 'last_station_id';
const KEY_CACHED_DATA = 'cached_data';
const KEY_AUTO_UPDATE = 'auto_update';
const KEY_BRIGHTNESS = 'brightness';

class AppSettings extends ChangeNotifier {
  DateTime get lastFetchTime => DateTime.fromMillisecondsSinceEpoch(
        SharedPrefs.instance.getInt(KEY_LAST_FETCH_TIME),
      );

  set lastFetchTime(DateTime dateTime) {
    SharedPrefs.instance.setInt(
      KEY_LAST_FETCH_TIME,
      dateTime.millisecondsSinceEpoch,
    );

    notifyListeners();
  }

  int get lastStationId => SharedPrefs.instance.getInt(KEY_LAST_STATION_ID);
  set lastStationId(int v) {
    SharedPrefs.instance.setInt(KEY_LAST_STATION_ID, v);
    notifyListeners();
  }

  String get cachedData => SharedPrefs.instance.getString(KEY_CACHED_DATA);
  set cachedData(String v) {
    SharedPrefs.instance.setString(KEY_CACHED_DATA, v);
    notifyListeners();
  }

  bool get autoUpdate => SharedPrefs.instance.getBool(KEY_CACHED_DATA);
  set autoUpdate(bool v) {
    SharedPrefs.instance.setBool(KEY_CACHED_DATA, v);
    notifyListeners();
  }

  Brightness get brightness {
    final _brightness = SharedPrefs.instance.getInt(KEY_BRIGHTNESS);
    if (_brightness == null) return null;

    return Brightness.values[_brightness];
  }

  set brightness(Brightness v) {
    SharedPrefs.instance.setInt(KEY_BRIGHTNESS, Brightness.values.indexOf(v));
    notifyListeners();
  }
}
