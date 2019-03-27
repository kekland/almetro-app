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
  double offset = 0.0;

  setArrivalsAndNextTrainIndex() {
    arrivals = getArrivalTimesBetweenStations(from: widget.departureStationIndex, to: widget.arrivalStationIndex);
    DateTime now = DateTime.now();
    nextTrainIndex = null;
    for (int index = 0; index < arrivals.length; index++) {
      if (arrivals[index].isAfter(now) && nextTrainIndex == null) {
        nextTrainIndex = index;
        break;
      }
    }
  }

  void redraw() {
    setState(() {});
    Future.delayed(Duration(seconds: 1), redraw);
  }

  @override
  void didUpdateWidget(ArrivalsPage oldWidget) {
    setArrivalsAndNextTrainIndex();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    scrollController = ScrollController(keepScrollOffset: true);
    setArrivalsAndNextTrainIndex();
    scrollController.addListener(() {
      offset =scrollController.offset;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => scrollController.jumpTo(offset));
    redraw();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    //scrollTo();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ListView.builder(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
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
    if (scrolled) {
      return null;
    }
    Future.delayed(Duration(milliseconds: 250), () {
      scrollController.animateTo(nextTrainIndex * 62.5, curve: Curves.elasticOut, duration: Duration(milliseconds: 1500));
      scrolled = true;
    });
    return null;
  }
}
