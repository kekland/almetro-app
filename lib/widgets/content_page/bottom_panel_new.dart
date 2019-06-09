import 'package:almaty_metro/api/stations.dart';
import 'package:almaty_metro/design/almetro_design.dart';
import 'package:almaty_metro/design/transparent_route.dart';
import 'package:almaty_metro/widgets/station_selection/station_selection_dialog.dart';
import 'package:flutter/material.dart';

class BottomPanelNew extends StatefulWidget {
  final Function(int) onStationIndexChange;

  const BottomPanelNew({Key key, this.onStationIndexChange}) : super(key: key);
  @override
  _BottomPanelNewState createState() => _BottomPanelNewState();
}

class _BottomPanelNewState extends State<BottomPanelNew> {
  int _stationIndex = 0;
  bool isPressActive = true;

  void _onLeftPress() {
    setState(() {
      isPressActive = true;
    });
    if (_stationIndex == 0) return;
    setState(() {
      _stationIndex--;
      widget.onStationIndexChange(_stationIndex);
    });
  }

  void _onPress(BuildContext context) async {
    int station = (await Navigator.of(context).push(
          TransparentRoute(
            builder: (_) {
              return StationSelectionDialog(selectedStation: _stationIndex);
            },
          ),
        )) ??
        -1;

    if (station != -1) {
      setState(() {
        _stationIndex = station;
        widget.onStationIndexChange(_stationIndex);
      });
    }
  }

  void _onRightPress() {
    setState(() {
      isPressActive = true;
    });
    if (_stationIndex == MetroData.stations.length - 1) return;
    setState(() {
      _stationIndex++;
      widget.onStationIndexChange(_stationIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      fluid: true,
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: (isPressActive) ? () => _onPress(context) : null,
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.chevron_left,
                    color: (_stationIndex != 0) ? Colors.red : Colors.black26,
                  ),
                ),
                borderRadius: BorderRadius.circular(64.0),
                onHighlightChanged: (_) =>
                    setState(() => isPressActive = false),
                onTap: _onLeftPress,
              ),
              SizedBox(width: 12.0),
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
              SizedBox(width: 12.0),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.chevron_right,
                    color: (_stationIndex != MetroData.stations.length - 1)
                        ? Colors.red
                        : Colors.black26,
                  ),
                ),
                borderRadius: BorderRadius.circular(64.0),
                radius: 100.0,
                onHighlightChanged: (_) =>
                    setState(() => isPressActive = false),
                onTap: _onRightPress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
