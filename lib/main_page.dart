import 'package:almaty_metro/bottom_panel.dart';
import 'package:almaty_metro/time.dart';
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
    for (var time in _arrivalTimes) {
      if (now.isBefore(time)) {
        return time;
      }
    }
    return null;
  }

  Time _getTimeUntilNextTrain() {
    DateTime closest = getClosestArrivalTime();
    if (closest == null) {
      throw "Метро не работает.";
    }
    DateTime now = DateTime.now();
    Duration difference = closest.difference(now);

    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });

    int minutes = difference.inMinutes;
    int seconds = difference.inSeconds - difference.inMinutes * 60;

    return Time(minutes, seconds);
  }

  Widget _buildCenterWidget() {
    Time time = _getTimeUntilNextTrain();
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 300.0,
      height: 300.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(150.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12.0,
            offset: Offset(0.0, 6.0),
            spreadRadius: 0.0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Ближайший поезд через', style: TextStyle(fontSize: 16.0, color: Colors.black45)),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${time.minute}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0)),
              Text('мин. ', style: TextStyle(fontSize: 28.0, color: Colors.black45)),
              Text('${time.second}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0)),
              Text('сек.', style: TextStyle(fontSize: 28.0, color: Colors.black45)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPageBackground(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0.0, -0.25),
              child: _buildCenterWidget(),
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
