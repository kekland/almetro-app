import 'package:almaty_metro/arrivals_page/arrival_times_list_widget.dart';
import 'package:almaty_metro/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:almaty_metro/time_calculator.dart';

class ArrivalsPage extends StatefulWidget {
  final int departureStationIndex;
  final int arrivalStationIndex;

  const ArrivalsPage({Key key, this.departureStationIndex, this.arrivalStationIndex}) : super(key: key);
  @override
  _ArrivalsPageState createState() => _ArrivalsPageState();
}

class _ArrivalsPageState extends State<ArrivalsPage> {
  List<DateTime> arrivals;
  ScrollController scrollController;
  int nextTrainIndex;
  bool scrolled = false;

  @override
  void didUpdateWidget(ArrivalsPage oldWidget) {
    if (widget.departureStationIndex != oldWidget.departureStationIndex &&
        widget.arrivalStationIndex != oldWidget.arrivalStationIndex) {
      arrivals = getArrivalTimesBetweenStations(from: widget.departureStationIndex, to: widget.arrivalStationIndex);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    arrivals = getArrivalTimesBetweenStations(from: widget.departureStationIndex, to: widget.arrivalStationIndex);
    scrollController = ScrollController(keepScrollOffset: true);
    /*scrollController.addListener(() {
      setState(() {});
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    nextTrainIndex = null;
    scrollTo();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ListView.builder(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
          if(arrivals[index].isAfter(now) && nextTrainIndex == null) {
            nextTrainIndex = index;
          }
          return Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: ArrivalTimeWidget(
              time: arrivals[index],
              now: now,
              nextTrain: nextTrainIndex == index,
            ),
          );
        },
        itemCount: arrivals.length,
      ),
    );
  }

  Future scrollTo() {
    scrollController.animateTo(nextTrainIndex * 34.0, curve: Curves.easeInOut, duration: Duration(milliseconds: 700));
    return null;
  }
}
