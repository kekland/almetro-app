import 'package:almaty_metro/api/stations.dart';
import 'package:almaty_metro/api/time.dart';
import 'package:almaty_metro/api/time_calculator.dart';
import 'package:almaty_metro/widgets/route_timer_page/departure_arrival_widgets.dart';
import 'package:almaty_metro/widgets/route_timer_page/next_train_widget.dart';
import 'package:almaty_metro/widgets/route_timer_page/total_time_widget.dart';
import 'package:flutter/material.dart';

class RouteTimerPage extends StatefulWidget {
  final int stationIndex;

  const RouteTimerPage({Key key, this.stationIndex}) : super(key: key);
  @override
  _RouteTimerPageState createState() => _RouteTimerPageState();
}

class _RouteTimerPageState extends State<RouteTimerPage> {
  int _stationIndex;

  List<DateTime> _arrivalTimesInMoscowDirection;
  List<DateTime> _arrivalTimesInRayimbekDirection;

  void _calculateArrivalTimes() {
    _arrivalTimesInMoscowDirection = MetroMath.getArrivalTimes(station: _stationIndex, direction: 1);
    _arrivalTimesInRayimbekDirection = MetroMath.getArrivalTimes(station: _stationIndex, direction: 0);
  }

  @override
  void didUpdateWidget(RouteTimerPage oldWidget) {
    if (oldWidget.stationIndex != widget.stationIndex) {
      _stationIndex = widget.stationIndex;
    }
    _calculateArrivalTimes();
    super.didUpdateWidget(oldWidget);
  }

  @override
  initState() {
    super.initState();
    _stationIndex = widget.stationIndex;
    _calculateArrivalTimes();
    timer();
  }

  void timer() async {
    DateTime now = DateTime.now();
    int millis = now.millisecond;
    await Future.delayed(Duration(milliseconds: 1000 - millis));
    while(true) {
      if (!mounted) return;
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
    }
  }

  Time _getTimeUntilNextTrain({List<DateTime> arrivalTimes}) {
    DateTime closest = MetroMath.getClosestArrivalTimeInList(arrivalTimes: arrivalTimes);
    if (closest == null) {
      throw "Метро не работает.";
    }
    DateTime now = DateTime.now();
    Duration difference = closest.difference(now);

    if(difference == null) return null;

    int minutes = difference.inMinutes;
    int seconds = difference.inSeconds - difference.inMinutes * 60;

    return Time(minutes, seconds);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NextTrainWidget(
                    title: "В сторону Москвы",
                    timeUntilNextTrain: (_stationIndex == 0)? null : _getTimeUntilNextTrain(arrivalTimes: _arrivalTimesInMoscowDirection),
                  ),
                  SizedBox(height: 16.0),
                  NextTrainWidget(
                    title: "В сторону ${MetroData.stations.last}",
                    timeUntilNextTrain: (_stationIndex == MetroData.stations.length - 1)? null : _getTimeUntilNextTrain(arrivalTimes: _arrivalTimesInRayimbekDirection),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
