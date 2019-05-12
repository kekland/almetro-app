import 'package:almaty_metro/api/time.dart';
import 'package:almaty_metro/api/time_calculator.dart';
import 'package:almaty_metro/widgets/route_timer_page/departure_arrival_widgets.dart';
import 'package:almaty_metro/widgets/route_timer_page/next_train_widget.dart';
import 'package:almaty_metro/widgets/route_timer_page/total_time_widget.dart';
import 'package:flutter/material.dart';

class RouteTimerPage extends StatefulWidget {
  final int departureStationIndex;
  final int arrivalStationIndex;

  const RouteTimerPage({Key key, this.departureStationIndex, this.arrivalStationIndex}) : super(key: key);
  @override
  _RouteTimerPageState createState() => _RouteTimerPageState();
}

class _RouteTimerPageState extends State<RouteTimerPage> {
  int _departureStationIndex;
  int _arrivalStationIndex;

  List<DateTime> _arrivalTimes;
  DateTime _departureTime;

  @override
  void didUpdateWidget(RouteTimerPage oldWidget) {
    if (oldWidget.departureStationIndex != widget.departureStationIndex) {
      _departureStationIndex = widget.departureStationIndex;
    }
    if (oldWidget.arrivalStationIndex != widget.arrivalStationIndex) {
      _arrivalStationIndex = widget.arrivalStationIndex;
    }

    _arrivalTimes = MetroMath.getArrivalTimesBetweenStations(from: _departureStationIndex, to: _arrivalStationIndex);
    _departureTime = MetroMath.getClosestArrivalTimeInList(arrivalTimes: _arrivalTimes);
    super.didUpdateWidget(oldWidget);
  }

  @override
  initState() {
    super.initState();

    _departureStationIndex = widget.departureStationIndex ?? 0;
    _arrivalStationIndex = widget.arrivalStationIndex ?? 8;

    _arrivalTimes = MetroMath.getArrivalTimesBetweenStations(from: _departureStationIndex, to: _arrivalStationIndex);
    _departureTime = MetroMath.getClosestArrivalTimeInList(arrivalTimes: _arrivalTimes);
  }

  Time _getTimeUntilNextTrain() {
    DateTime closest = MetroMath.getClosestArrivalTimeInList(arrivalTimes: _arrivalTimes);
    if (closest == null) {
      throw "Метро не работает.";
    }
    DateTime now = DateTime.now();
    Duration difference = closest.difference(now);

    Future.delayed(Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {});
    });

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
                  DepartureTimeWidget(
                    arrivalStationIndex: _arrivalStationIndex,
                    departureStationIndex: _departureStationIndex,
                    departureTime: _departureTime,
                  ),
                  SizedBox(height: 16.0),
                  ArrivalTimeWidget(
                    arrivalStationIndex: _arrivalStationIndex,
                    departureStationIndex: _departureStationIndex,
                    departureTime: _departureTime,
                  ),
                  SizedBox(height: 16.0),
                  TotalTimeWidget(
                    arrivalStationIndex: _arrivalStationIndex,
                    departureStationIndex: _departureStationIndex,
                  ),
                  SizedBox(height: 16.0),
                  NextTrainWidget(
                    arrivalStationIndex: _arrivalStationIndex,
                    departureStationIndex: _departureStationIndex,
                    timeUntilNextTrain: _getTimeUntilNextTrain(),
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
