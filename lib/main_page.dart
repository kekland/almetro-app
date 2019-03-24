import 'package:almaty_metro/arrival_times_list_widget.dart';
import 'package:almaty_metro/bottom_panel.dart';
import 'package:almaty_metro/card_widget.dart';
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

  Widget _buildNextTrainWidget() {
    Time time = _getTimeUntilNextTrain();
    Color color = (time.inSeconds() <= 60) ? Colors.red.shade700 : Colors.black;
    return CardWidget(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Следующий поезд через', style: TextStyle(fontSize: 16.0, color: Colors.black45)),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('${time.minute}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: color)),
              Text('мин. ', style: TextStyle(fontSize: 18.0, color: Colors.black45)),
              Text('${time.second}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: color)),
              Text('сек.', style: TextStyle(fontSize: 18.0, color: Colors.black45)),
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: ArrivalTimesListWidget(arrivalTimes: _arrivalTimes),
                ),
                SizedBox(height: 16.0),
                _buildNextTrainWidget(),
                SizedBox(height: 16.0),
                BottomPanel(
                  onChange: (int stationIndex, int directionIndex) {
                    setState(() {
                      _stationIndex = stationIndex;
                      _directionIndex = directionIndex;
                      _arrivalTimes = getArrivalTimes(stationIndex, directionIndex);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
