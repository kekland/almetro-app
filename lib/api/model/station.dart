import 'package:almaty_metro/api/model/line.dart';
import 'package:almaty_metro/api/model/segment.dart';
import 'package:almaty_metro/api/time.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SubwayStationName {
  final String kk;
  final String ru;
  final String en;

  SubwayStationName({
    @required this.kk,
    @required this.ru,
    @required this.en,
  });

  Map<String, dynamic> toJson() => {'kk': kk, 'ru': ru, 'en': en};

  String resolveFromLocale(
    Locale locale, [
    Locale fallbackLocale = const Locale('ru'),
  ]) {
    switch (locale.languageCode) {
      case 'ru':
        return ru;
      case 'kk':
        return kk;
      case 'en':
        return en;
      case 'de':
        return en;
      default:
        return resolveFromLocale(fallbackLocale);
    }
  }

  factory SubwayStationName.fromJson(Map<String, dynamic> json) {
    return SubwayStationName(
      kk: json['kk'],
      ru: json['ru'],
      en: json['en'],
    );
  }
}

class SubwayStation {
  final int id;
  final SubwayStationName name;

  /// Key is [SubwayLine.id]
  final Map<int, List<SubwaySegment>> connections;

  /// Key is [SubwayStation.id]
  final Map<int, List<Time>> schedule;

  final int order;
  final double latitude;
  final double longitude;

  SubwayStation({
    @required this.id,
    @required this.name,
    @required this.connections,
    @required this.schedule,
    @required this.order,
    @required this.latitude,
    @required this.longitude,
  });

  SubwayStation copyWith({
    int id,
    String name,
    List<SubwaySegment> connections,
    List<Time> schedule,
    int order,
    double latitude,
    double longitude,
  }) {
    return SubwayStation(
      id: id ?? this.id,
      name: name ?? this.name,
      connections: connections ?? this.connections,
      schedule: schedule ?? this.schedule,
      order: order ?? this.order,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  void populateSchedule({
    @required int stationId,
    @required List<Time> schedule,
  }) {
    if (this.schedule[stationId] == null) {
      this.schedule[stationId] = schedule;
      return;
    }

    final lineSchedule = this.schedule[stationId];
    lineSchedule.addAll(schedule.where((v) => !lineSchedule.contains(v)));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.toJson(),
      'connections': connections.map(
        (k, v) => MapEntry(k.toString(), v.map((c) => c.toJson()).toList()),
      ),
      'schedule': schedule.map(
        (k, v) => MapEntry(k.toString(), v.map((c) => c.toString()).toList()),
      ),
      'order': order,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory SubwayStation.fromJson(Map<String, dynamic> json) {
    return SubwayStation(
      id: json['id'],
      name: json['name'],
      connections: json['connections'].map(
        (k, v) => MapEntry(k, v.map((c) => SubwaySegment.fromJson(c)).toList()),
      ),
      schedule: json['schedule'].map(
        (k, v) => MapEntry(k, v.map((c) => Time.parse(c)).toList()),
      ),
      order: json['order'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
