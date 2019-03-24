import 'package:almaty_metro/card_widget.dart';
import 'package:almaty_metro/icon_text_widget.dart';
import 'package:almaty_metro/station_selector.dart';
import 'package:flutter/material.dart';
import 'package:almaty_metro/stations.dart';

class BottomPanel extends StatefulWidget {
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  int _stationIndex = 0;
  int _direction = 0;
  List<int> _availableDirections = [0, 1];

  _onStationLeftPress() {
    setState(() {
      _stationIndex--;

      if (_stationIndex == 0) {
        _availableDirections = [1];
        _direction = 1;
      } else {
        _availableDirections = [0, 1];
      }
    });
  }

  _onStationRightPress() {
    setState(() {
      _stationIndex++;

      if (_stationIndex == stations.length - 1) {
        _availableDirections = [0];
        _direction = 0;
      } else {
        _availableDirections = [0, 1];
      }
    });
  }

  _onDirectionLeftPress() {
    setState(() {
      _direction--;
    });
  }

  _onDirectionRightPress() {
    setState(() {
      _direction++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 16.0,
      ),
      child: CardWidget(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconTextWidget(
              title: stations[_stationIndex],
              subtitle: 'Станция',
              icon: Icons.subway,
              isTop: true,
              onLeftPress: _stationIndex > 0 ? _onStationLeftPress : null,
              onRightPress: _stationIndex < stations.length - 1 ? _onStationRightPress : null,
            ),
            Container(
              width: double.infinity,
              height: 2.0,
              color: Colors.black.withOpacity(0.05),
            ),
            IconTextWidget(
              title: directions[_direction],
              subtitle: 'В сторону',
              icon: Icons.directions,
              isTop: false,
              onLeftPress: (_direction > 0 && _availableDirections.length > 1) ? _onDirectionLeftPress : null,
              onRightPress: (_direction < directions.length - 1 && _availableDirections.length > 1)
                  ? _onDirectionRightPress
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
