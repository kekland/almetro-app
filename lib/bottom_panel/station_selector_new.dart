import 'package:almaty_metro/bottom_panel/station_selector_circle.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:almaty_metro/stations.dart' as data;

class StationSelectorNew extends StatefulWidget {
  final Function(int index) onStationChange;
  final int stationsCount;
  final int defaultStation;

  const StationSelectorNew({Key key, this.onStationChange, this.stationsCount, this.defaultStation}) : super(key: key);

  @override
  _StationSelectorNewState createState() => _StationSelectorNewState();
}

class _StationSelectorNewState extends State<StationSelectorNew> {
  int _selectedStation = 0;
  List<GlobalKey> _stationWidgets = [];

  @override
  initState() {
    super.initState();
    _stationWidgets = [];
    for (int i = 0; i < widget.stationsCount; i++) {
      GlobalKey key = GlobalKey();
      _stationWidgets.add(key);
    }
    
    _selectedStation = widget.defaultStation;
  }

  List<Widget> _buildRowChildren() {
    List<Widget> children = [];

    for (int i = 0; i < widget.stationsCount; i++) {
      children.add(
        Expanded(
          key: _stationWidgets[i],
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: StationCircle(activated: i == _selectedStation),
            ),
          ),
        ),
      );
    }
    return children;
  }

  _setSelectedStation(Offset point) {
    for (int i = 0; i < widget.stationsCount; i++) {
      var widgetKey = _stationWidgets[i];
      RenderBox renderBox = widgetKey.currentContext.findRenderObject();
      var position = renderBox.localToGlobal(Offset.zero);
      var size = renderBox.size;

      if (point.dx >= position.dx && point.dx <= position.dx + size.width) {
        setState(() {
          _selectedStation = i;
          widget.onStationChange(_selectedStation);
        });
        break;
      }
    }
  }

  _onPanStart(details) {
    _setSelectedStation(details.globalPosition);
  }

  _onPanEnd(details) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: (details) => _setSelectedStation(details.globalPosition),
        onPanEnd: _onPanEnd,
        child: Row(
          children: _buildRowChildren(),
        ),
      ),
    );
  }
}
