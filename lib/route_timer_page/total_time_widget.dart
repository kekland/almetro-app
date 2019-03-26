import 'package:almaty_metro/icon_content_widget.dart';
import 'package:almaty_metro/time_calculator.dart';
import 'package:flutter/material.dart';

class TotalTimeWidget extends StatelessWidget {
  final int departureStationIndex;
  final int arrivalStationIndex;

  const TotalTimeWidget({Key key, this.departureStationIndex, this.arrivalStationIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Duration travelTime = getTimeBetweenTwoStations(departureStationIndex, arrivalStationIndex);

    int minutes = travelTime.inMinutes;
    int seconds = travelTime.inSeconds - travelTime.inMinutes * 60;
    Color color = Colors.black;

    return IconContentWidget(
      icon: Icons.timer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Время в пути', style: TextStyle(fontSize: 16.0, color: Colors.black45)),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: (arrivalStationIndex == departureStationIndex)
                ? [
                    Text(
                      '-',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: color),
                    )
                  ]
                : [
                    Text('${minutes}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: color)),
                    Text('мин. ', style: TextStyle(fontSize: 18.0, color: Colors.black45)),
                    Text('${seconds}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: color)),
                    Text('сек.', style: TextStyle(fontSize: 18.0, color: Colors.black45)),
                  ],
          ),
        ],
      ),
    );
  }
}
