import 'package:almaty_metro/main_page_background.dart';
import 'package:almaty_metro/route_timer_page/bottom_panel.dart';
import 'package:almaty_metro/route_timer_page/departure_arrival_widgets.dart';
import 'package:almaty_metro/route_timer_page/next_train_widget.dart';
import 'package:almaty_metro/route_timer_page/total_time_widget.dart';
import 'package:almaty_metro/time.dart';
import 'package:almaty_metro/time_calculator.dart';
import 'package:flutter/material.dart';

class RouteTimerPage extends StatefulWidget {
  const RouteTimerPage({Key key}) : super(key: key);
  @override
  _RouteTimerPageState createState() => _RouteTimerPageState();
}

class _RouteTimerPageState extends State<RouteTimerPage>{
  int _departureStationIndex;
  int _arrivalStationIndex;
  List<DateTime> _arrivalTimes;

  @override
  initState() {
    super.initState();

    _departureStationIndex =  0;
    _arrivalStationIndex = 8;

    _arrivalTimes = getArrivalTimes(_departureStationIndex, _arrivalStationIndex);
  }

  int getDirection() {
    if (_arrivalStationIndex > _departureStationIndex) {
      return 1;
    } else {
      return 0;
    }
  }

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
                    departureTime: getClosestArrivalTime(),
                  ),
                  SizedBox(height: 16.0),
                  ArrivalTimeWidget(
                    arrivalStationIndex: _arrivalStationIndex,
                    departureStationIndex: _departureStationIndex,
                    departureTime: getClosestArrivalTime(),
                  ),
                  SizedBox(height: 16.0),
                  TotalTimeWidget(
                    departureStationIndex: _departureStationIndex,
                    arrivalStationIndex: _arrivalStationIndex,
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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: BottomPanel(
            onChange: (int departureStationIndex, int arrivalStationIndex) {
              setState(() {
                _departureStationIndex = departureStationIndex;
                _arrivalStationIndex = arrivalStationIndex;
                _arrivalTimes = getArrivalTimes(departureStationIndex, getDirection());
                //PageStorage.of(context)?.writeState(context, departureStationIndex, identifier: 'departureStationIndex');
                //PageStorage.of(context)?.writeState(context, arrivalStationIndex, identifier: 'arrivalStationIndex');
              });
            },
          ),
        ),
      ],
    );
  }
}
