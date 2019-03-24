import 'package:almaty_metro/bottom_panel.dart';
import 'package:almaty_metro/time_calculator.dart';
import 'package:flutter/material.dart';

class MainPageBackground extends StatelessWidget {
  final Widget child;

  const MainPageBackground({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red,
            Colors.pink,
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: child,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _stationIndex = 0;
  int _directionIndex = 1;
  List<DateTime> _arrivalTimes = getArrivalTimes(0, 8);

  DateTime getClosestArrivalTime() {
    DateTime now = DateTime.now();
    for(var time in _arrivalTimes) {
      if(now.isAfter(time)) {
        return time;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPageBackground(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "$_stationIndex $_directionIndex",
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: BottomPanel(
                onChange: (int stationIndex, int directionIndex) {
                  setState(() {
                    _stationIndex = stationIndex;
                    _directionIndex = directionIndex;
                    _arrivalTimes = getArrivalTimes(stationIndex, directionIndex);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
