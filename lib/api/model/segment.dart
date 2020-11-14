import 'package:almaty_metro/api/model/station.dart';
import 'package:flutter/foundation.dart';

class SubwaySegment {
  final int lineId;
  final int from;
  final int to;

  SubwaySegment({
    @required this.lineId,
    @required this.from,
    @required this.to,
  });

  SubwaySegment copyWith({
    int lineId,
    int from,
    int to,
  }) {
    return SubwaySegment(
      lineId: lineId ?? this.lineId,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lineId': lineId,
      'from': from,
      'to': to,
    };
  }

  factory SubwaySegment.fromJson(Map<String, dynamic> json) {
    return SubwaySegment(
      lineId: json['lineId'],
      from: json['from'],
      to: json['to'],
    );
  }
}
