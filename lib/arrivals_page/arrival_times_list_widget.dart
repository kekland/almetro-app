import 'package:almaty_metro/card_widget.dart';
import 'package:almaty_metro/time.dart';
import 'package:flutter/material.dart';

class ArrivalTimeWidget extends StatelessWidget {
  final DateTime time;
  final DateTime now;
  final bool nextTrain;

  const ArrivalTimeWidget({Key key, this.time, this.now, this.nextTrain}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool passed = (now.isAfter(time));
    Duration difference = time.difference(now);

    int hours = difference.inHours;
    int minutes = difference.inMinutes - difference.inHours * 60;
    int seconds = difference.inSeconds - difference.inMinutes * 60;
    TextStyle style = TextStyle(
      color: (nextTrain)? Colors.black87 : Colors.black38,
      fontWeight: (nextTrain)? FontWeight.w500 : FontWeight.w400,
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
                      color: (nextTrain) ? Colors.red : Colors.black,
                      fontSize: 18.0,
                      fontWeight: (nextTrain) ? FontWeight.w500 : FontWeight.w400,
                    ),
            ),
            Expanded(child: SizedBox()),
            secondText,
          ],
        ),
      ),
    );
  }
}