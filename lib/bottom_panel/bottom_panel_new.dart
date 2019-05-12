import 'package:almaty_metro/bottom_panel/station_selector_new.dart';
import 'package:almaty_metro/card_widget.dart';
import 'package:almaty_metro/stations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

//TODO: Rename when finished
class BottomPanelNew extends StatefulWidget {
  @override
  _BottomPanelNewState createState() => _BottomPanelNewState();
}

class _BottomPanelNewState extends State<BottomPanelNew> {
  int _departureStationIndex = 0;
  int _arrivalStationIndex = stations.length - 1;
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      fluid: true,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Text(
                stations[_departureStationIndex],
                style: TextStyle(
                  fontSize: 28.0,
                  fontFamily: 'Futura',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                FontAwesomeIcons.arrowRight,
                color: Colors.black12,
                size: 20.0,
              ),
              Text(
                stations[_arrivalStationIndex],
                style: TextStyle(
                  fontSize: 28.0,
                  fontFamily: 'Futura',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          RangeSlider(
            lowerValue: 0.0,
            upperValue: stations.length.toDouble(),
            divisions: stations.length,
            min: 0.0,
            max: stations.length.toDouble(),
            showValueIndicator: true,
            onChanged: (double lower, double upper) {},
          ),
        ],
      ),
    );
  }
}
