import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:almaty_metro/stations.dart' as data;

class StationCircle extends StatelessWidget {
  final bool activated;

  const StationCircle({Key key, this.activated = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.0,
      height: 16.0,
      decoration: BoxDecoration(
        color: (activated) ? Colors.red : Colors.black.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}

class StationSelectorNew extends StatefulWidget {
  @override
  _StationSelectorNewState createState() => _StationSelectorNewState();
}

class _StationSelectorNewState extends State<StationSelectorNew> {
  int selectedStation = 0;
  int stations = 8;
  List<GlobalKey> stationWidgets = [];

  @override
  initState() {
    super.initState();
    stationWidgets = [];
    for (int i = 0; i < stations; i++) {
      GlobalKey key = GlobalKey();
      stationWidgets.add(key);
    }
  }

  List<Widget> _buildRowChildren() {
    List<Widget> children = [];

    for (int i = 0; i < stations; i++) {
      children.add(
        Expanded(
          key: stationWidgets[i],
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: StationCircle(activated: i == selectedStation),
            ),
          ),
        ),
      );
    }
    return children;
  }

  _setSelectedStation(Offset point) {
    for (int i = 0; i < stations; i++) {
      var widgetKey = stationWidgets[i];
      RenderBox renderBox = widgetKey.currentContext.findRenderObject();
      var position = renderBox.localToGlobal(Offset.zero);
      var size = renderBox.size;

      if (point.dx >= position.dx && point.dx <= position.dx + size.width) {
        setState(() {
          selectedStation = i;
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
