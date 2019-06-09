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

  List<Time> _getNextTrains({List<DateTime> arrivalTimes}) {
    int closestIndex = MetroMath.getClosestArrivalTimeIndexInList(arrivalTimes: arrivalTimes);
    if (closestIndex == null) {
      return [null, null, null];
    }
    
    List<Time> times = [];
    DateTime now = DateTime.now();

    for(int offset = 0; offset < 3; offset++) {
      int index = closestIndex + offset;
      DateTime closest = (index < arrivalTimes.length)? arrivalTimes[index] : null;
      if(closest == null) times.add(null);
      else times.add(Time.fromDuration(closest.difference(now)));
    }
    
    return times;
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
                    icon: Icons.chevron_left,
                    nextTrains: (_stationIndex == 0)? null : _getNextTrains(arrivalTimes: _arrivalTimesInMoscowDirection),
                  ),
                  SizedBox(height: 16.0),
                  NextTrainWidget(
                    title: "В сторону Райымбек Батыра",
                    icon: Icons.chevron_right,
                    nextTrains: (_stationIndex == MetroData.stations.length - 1)? null : _getNextTrains(arrivalTimes: _arrivalTimesInRayimbekDirection),
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
