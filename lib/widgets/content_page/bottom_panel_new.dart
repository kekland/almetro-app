import 'package:almaty_metro/api/stations.dart';
import 'package:almaty_metro/design/almetro_design.dart';
import 'package:flutter/material.dart';

class BottomPanelNew extends StatefulWidget {
  @override
  _BottomPanelNewState createState() => _BottomPanelNewState();
}

class _BottomPanelNewState extends State<BottomPanelNew> {
  int _departureStationIndex = 0;
  int _arrivalStationIndex = MetroData.stations.length - 1;
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
            style: AlmetroTextStyle.caption,
          ),
          Text(
            'Москва',
            style: AlmetroTextStyle.boldInformation,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: DividerWidget(),
          ),
          Text(
            'Куда',
            style: AlmetroTextStyle.caption,
          ),
          Text(
            'Райымбек батыра',
            style: AlmetroTextStyle.boldInformation,
          ),
        ],
      ),
    );
  }
}
