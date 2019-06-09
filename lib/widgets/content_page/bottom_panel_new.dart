import 'package:almaty_metro/api/stations.dart';
import 'package:almaty_metro/design/almetro_design.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.chevron_left),
            color: Colors.red,
            onPressed: (_stationIndex != 0)
                ? () => setState(() => _stationIndex--)
                : null,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Станция',
                  style: AlmetroTextStyle.caption,
                ),
                Text(
                  MetroData.stations[_stationIndex],
                  style: AlmetroTextStyle.boldInformation,
                ),
              ],
            ),
          ),
          SizedBox(width: 16.0),
          IconButton(
            icon: Icon(Icons.chevron_right),
            color: Colors.red,
            onPressed: (_stationIndex != MetroData.stations.length - 1)
                ? () => setState(() => _stationIndex++)
                : null,
          ),
        ],
      ),
    );
  }
}
