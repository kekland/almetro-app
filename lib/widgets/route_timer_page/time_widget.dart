import 'package:almaty_metro/api/time.dart';
import 'package:flutter/material.dart';

class TimeWidget extends StatelessWidget {
  final Time time;

  const TimeWidget({Key key, this.time}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color color = (time != null && time.inSeconds() <= 60)
        ? Colors.red.shade700
        : Colors.black;

    return (time == null)
        ? Text(
            '-',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28.0,
                color: Colors.black),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('${time.minute}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28.0,
                      color: color)),
              Text('мин. ',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black45,
                      fontFamily: 'Futura')),
              Text('${time.second}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28.0,
                      color: color)),
              Text('сек.',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black45,
                      fontFamily: 'Futura')),
            ],
          );
  }
}
