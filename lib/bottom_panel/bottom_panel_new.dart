import 'package:almaty_metro/bottom_panel/station_selector_new.dart';
import 'package:almaty_metro/card_widget.dart';
import 'package:almaty_metro/stations.dart';
import 'package:flutter/material.dart';

//TODO: Rename when finished
class BottomPanelNew extends StatefulWidget {
  @override
  _BottomPanelNewState createState() => _BottomPanelNewState();
}

class _BottomPanelNewState extends State<BottomPanelNew> {
  int _stationIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      fluid: true,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Text(
            stations[_stationIndex],
            style: TextStyle(
              fontSize: 28.0,
              fontFamily: 'Futura',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.0),
          StationSelectorNew(
            defaultStation: 0,
            onStationChange: (int station) {
              setState(() {
                _stationIndex = station;
              });
            },
          ),
        ],
      ),
    );
  }
}
