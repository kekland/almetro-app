import 'package:almaty_metro/card_widget.dart';
import 'package:almaty_metro/time.dart';
import 'package:flutter/material.dart';

class ArrivalTimesListWidget extends StatefulWidget {
  final List<DateTime> arrivalTimes;

  const ArrivalTimesListWidget({Key key, this.arrivalTimes}) : super(key: key);

  @override
  _ArrivalTimesListWidgetState createState() => _ArrivalTimesListWidgetState();
}

class _ArrivalTimesListWidgetState extends State<ArrivalTimesListWidget> {
  ScrollController controller;
  int currentIndex = null;
  bool animated = false;

  @override
  didUpdateWidget(ArrivalTimesListWidget oldWidget) {
    DateTime now = DateTime.now();
    currentIndex = null;
    widget.arrivalTimes.forEach((time) {
      if (currentIndex != null) return;
      if (time.isAfter(now)) {
        currentIndex = widget.arrivalTimes.indexOf(time);
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  initState() {
    super.initState();
    DateTime now = DateTime.now();
    currentIndex = null;
    widget.arrivalTimes.forEach((time) {
      if (currentIndex != null) return;
      if (time.isAfter(now)) {
        currentIndex = widget.arrivalTimes.indexOf(time);
      }
    });
  }

  Widget _buildRow(int index) {
    DateTime time = widget.arrivalTimes[index];
    DateTime now = DateTime.now();
    Duration difference = time.difference(now);

    bool passed = (now.isAfter(time));

    int hours = difference.inHours;
    int minutes = difference.inMinutes - difference.inHours * 60;
    int seconds = difference.inSeconds - difference.inMinutes * 60;
    TextStyle style = TextStyle(
      color: Colors.black38,
    );

    String text =
        (hours > 0) ? 'через ${hours}ч. ${minutes}мин. ${seconds}сек.' : 'через ${minutes}мин. ${seconds}сек.';

    Text secondText = (passed) ? Text('проехал', style: style) : Text(text, style: style);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: CardWidget(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              '${dateTimeToHourOfDayString(time)}',
              style: (passed)
                  ? TextStyle(
                      color: Colors.black38,
                      fontSize: 18.0,
                    )
                  : TextStyle(
                      color: (currentIndex == index) ? Colors.red : Colors.black,
                      fontSize: 18.0,
                      fontWeight: (currentIndex == index) ? FontWeight.w600 : FontWeight.w400,
                    ),
            ),
            Expanded(child: SizedBox()),
            secondText,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: controller,
        itemCount: widget.arrivalTimes.length,
        itemBuilder: (context, index) => _buildRow(index),
        physics: BouncingScrollPhysics());
  }
}
