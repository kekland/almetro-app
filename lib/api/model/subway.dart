import 'package:almaty_metro/api/model/line.dart';
import 'package:almaty_metro/api/model/schedule_type.dart';
import 'package:almaty_metro/api/model/station.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

class Subway {
  final Map<ScheduleType, SubwayData> schedules;
  final List<Tuple2<DateTime, String>> holidays;

  Subway({
    @required this.schedules,
    @required this.holidays,
  });
}

class SubwayData {
  final List<SubwayLine> lines;
  final Map<SubwayStation, List<SubwayStation>> lineConnections;

  SubwayData({
    @required this.lines,
    @required this.lineConnections,
  });

  SubwayData copyWith({
    List<SubwayLine> lines,
    Map<SubwayStation, List<SubwayStation>> lineConnections,
  }) {
    return SubwayData(
      lines: lines ?? this.lines,
      lineConnections: lineConnections ?? this.lineConnections,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lines': lines.map((v) => v.toJson()).toList(),
      'lineConnections': lineConnections.map(
        (k, v) => MapEntry(k.id, v.map((s) => s.toJson()).toList()),
      ),
    };
  }

  factory SubwayData.fromJson(Map<String, dynamic> json) {
    return SubwayData(
      lines: json['lines'].map((v) => SubwayLine.fromJson(v)).toList(),
      lineConnections: {},
    );
  }
}
