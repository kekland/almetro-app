import 'package:almaty_metro/bottom_panel/station_selector_new.dart';
import 'package:almaty_metro/card_widget.dart';
import 'package:almaty_metro/stations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import '../icon_content_widget.dart';

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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Откуда',
            style: TextStyle(fontSize: 14.0, color: Colors.black45),
          ),
          Text(
            'Москва',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: Colors.black),
          ),
          SizedBox(height: 16.0),
          Text(
            'Куда',
            style: TextStyle(fontSize: 14.0, color: Colors.black45),
          ),
          Text(
            'Райымбек батыра',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
