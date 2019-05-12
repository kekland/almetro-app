import 'package:almaty_metro/bottom_panel/station_selector_circle.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:flutter/material.dart';
import 'package:almaty_metro/stations.dart' as data;

class StationSelectorNew extends StatefulWidget {
  final Function(int index) onStationChange;
  final int defaultStation;

  const StationSelectorNew({Key key, this.onStationChange, this.defaultStation}) : super(key: key);

  @override
  _StationSelectorNewState createState() => _StationSelectorNewState();
}

class _StationSelectorNewState extends State<StationSelectorNew> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
