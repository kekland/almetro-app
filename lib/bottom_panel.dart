import 'package:almaty_metro/card_widget.dart';
import 'package:almaty_metro/icon_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:almaty_metro/stations.dart';

class BottomPanel extends StatefulWidget {
  final Function(int departureStationIndex, int arrivalStationIndex) onChange;

  const BottomPanel({Key key, this.onChange}) : super(key: key);
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  int _departureStationIndex = 0;
  int _arrivalStationIndex = 8;

  _onArrivalStationLeftPress() {
    setState(() {
      _arrivalStationIndex--;
      widget.onChange(_departureStationIndex, _arrivalStationIndex);
    });
  }

  _onArrivalStationRightPress() {
    setState(() {
      _arrivalStationIndex++;
      widget.onChange(_departureStationIndex, _arrivalStationIndex);
    });
  }

  _onDepartureStationLeftPress() {
    setState(() {
      _departureStationIndex--;
      widget.onChange(_departureStationIndex, _arrivalStationIndex);
    });
  }

  _onDepartureStationRightPress() {
    setState(() {
      _departureStationIndex++;
      widget.onChange(_departureStationIndex, _arrivalStationIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTextWidget(
            title: stations[_departureStationIndex],
            subtitle: 'Со станции',
            icon: Icons.subway,
            isTop: true,
            onLeftPress: _departureStationIndex > 0 ? _onDepartureStationLeftPress : null,
            onRightPress: _departureStationIndex < stations.length - 1 ? _onDepartureStationRightPress : null,
          ),
          Container(
            width: double.infinity,
            height: 2.0,
            color: Colors.black.withOpacity(0.05),
          ),
          IconTextWidget(
            title: stations[_arrivalStationIndex],
            subtitle: 'На станцию',
            icon: Icons.directions,
            isTop: false,
            onLeftPress: _arrivalStationIndex > 0 ? _onArrivalStationLeftPress : null,
            onRightPress: _arrivalStationIndex < stations.length - 1 ? _onArrivalStationRightPress : null,
          ),
        ],
      ),
    );
  }
}
