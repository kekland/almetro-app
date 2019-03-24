import 'package:almaty_metro/card_widget.dart';
import 'package:almaty_metro/station_widget.dart';
import 'package:flutter/material.dart';
import 'package:almaty_metro/stations.dart' as data;

class StationSelectorWidget extends StatefulWidget {
  @override
  _StationSelectorWidgetState createState() => _StationSelectorWidgetState();
}

class _StationSelectorWidgetState extends State<StationSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: data.stations.map((station) => StationWidget(name: station)).toList(),
    );
  }
}
