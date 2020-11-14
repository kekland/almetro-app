import 'package:almaty_metro/api/model/line.dart';
import 'package:almaty_metro/api/model/schedule_type.dart';
import 'package:almaty_metro/api/model/station.dart';
import 'package:flutter/foundation.dart';

class Subway {
  final Map<ScheduleType, SubwayData> schedules;
  final List<DateTime> holidays;

  Subway({
    @required this.schedules,
    @required this.holidays,
  });

  Map<String, dynamic> toJson() {
    return {
      'schedules': schedules.map((k, v) => MapEntry(k.toString(), v.toJson())),
      'holidays': holidays.map((v) => v.millisecondsSinceEpoch).toList(),
    };
  }

  factory Subway.fromJson(Map<String, dynamic> json) {
    return Subway(
      schedules: json['schedules'].map(
        (k, v) => MapEntry(
          scheduleTypeFromJson(k),
          SubwayData.fromJson(v),
        ),
      ),
      holidays: json['holidays']
          .map((v) => DateTime.fromMillisecondsSinceEpoch(v))
          .toList(),
    );
  }
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
