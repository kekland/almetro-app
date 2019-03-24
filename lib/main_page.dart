import 'package:almaty_metro/arrival_times_list_widget.dart';
import 'package:almaty_metro/bottom_panel.dart';
import 'package:almaty_metro/card_widget.dart';
import 'package:almaty_metro/departure_arrival_widgets.dart';
import 'package:almaty_metro/icon_content_widget.dart';
import 'package:almaty_metro/info_page.dart';
import 'package:almaty_metro/next_train_widget.dart';
import 'package:almaty_metro/time.dart';
import 'package:almaty_metro/time_calculator.dart';
import 'package:almaty_metro/total_time_widget.dart';
import 'package:flutter/material.dart';

class MainPageBackground extends StatefulWidget {
  final Widget child;

  const MainPageBackground({Key key, this.child}) : super(key: key);

  @override
  _MainPageBackgroundState createState() => _MainPageBackgroundState();
}

class _MainPageBackgroundState extends State<MainPageBackground> {
  int index = -1;
  List<Color> colors = [
    Colors.pink,
    Colors.red,
  ];

  List<List<Color>> allColors = [
    [
      Colors.pink,
      Colors.red,
    ],
    [
      Colors.pink,
      Colors.redAccent,
    ],
    [
      Colors.red,
      Colors.redAccent,
    ],
    [
      Colors.red,
      Colors.pink,
    ],
    [
      Colors.red,
      Colors.redAccent,
    ],
    [
      Colors.pink,
      Colors.redAccent,
    ],
    [
      Colors.pink,
      Colors.red,
    ],
  ];

  void changeColors() {
    index++;
    if (index >= allColors.length) {
      index = 0;
    }
    setState(() {
      colors = allColors[index];
      Future.delayed(Duration(milliseconds: 1000), changeColors);
    });
  }

  @override
  void initState() {
    super.initState();

    changeColors();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: widget.child,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _departureStationIndex = 0;
  int _arrivalStationIndex = 8;
  List<DateTime> _arrivalTimes = getArrivalTimes(0, 1);

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
      setState(() {});
    });

    int minutes = difference.inMinutes;
    int seconds = difference.inSeconds - difference.inMinutes * 60;

    return Time(minutes, seconds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPageBackground(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 56.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Метро.Алматы',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.info, color: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => InformationSheetWidget(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
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
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
