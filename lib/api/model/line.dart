import 'package:almaty_metro/api/model/segment.dart';
import 'package:almaty_metro/api/model/station.dart';
import 'package:flutter/foundation.dart';

class SubwayLine {
  final int id;
  final List<SubwayStation> stations;
  final List<SubwaySegment> segments;

  SubwayLine({
    @required this.id,
    @required this.stations,
    @required this.segments,
  });

  SubwayLine copyWith({
    int id,
    List<SubwayStation> stations,
    List<SubwaySegment> segments,
  }) {
    return SubwayLine(
      id: id ?? this.id,
      stations: stations ?? this.stations,
      segments: segments ?? this.segments,
    );
  }

  List<SubwaySegment> getIncomingConnectionsForStation(
    SubwayStation station, [
    int lineId,
  ]) {
    return segments.where((v) {
      if (v.to == station.id) {
        return (lineId != null) ? lineId == v.lineId : true;
      }
      return false;
    }).toList();
  }

  List<SubwaySegment> getOutgoingConnectionsForStation(
    SubwayStation station, [
    int lineId,
  ]) {
    return segments.where((v) {
      if (v.from == station.id) {
        return (lineId != null) ? lineId == v.lineId : true;
      }
      return false;
    }).toList();
  }

  SubwayStation getStationWithId(int id) {
    return stations.singleWhere((v) => v.id == id);
  }

  int getStationIndex(SubwayStation station) {
    return stations.indexOf(station);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stations': stations.map((v) => v.toJson()).toList(),
      'segments': segments.map((v) => v.toJson()).toList(),
    };
  }

  factory SubwayLine.fromJson(Map<String, dynamic> json) {
    return SubwayLine(
      id: json['id'],
      stations: json['stations'].map((v) => SubwayStation.fromJson(v)).toList(),
      segments: json['segments'].map((v) => SubwaySegment.fromJson(v)).toList(),
    );
  }
}
