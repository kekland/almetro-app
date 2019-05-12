import 'package:almaty_metro/api/time.dart';
import 'package:almaty_metro/widgets/shared/icon_content_widget.dart';
import 'package:flutter/material.dart';

class NextTrainWidget extends StatelessWidget {
  final Time timeUntilNextTrain;
  final int arrivalStationIndex;
  final int departureStationIndex;

  const NextTrainWidget({Key key, this.timeUntilNextTrain, this.arrivalStationIndex, this.departureStationIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color color = (timeUntilNextTrain.inSeconds() <= 60) ? Colors.red.shade700 : Colors.black;
    return IconContentWidget(
      icon: Icons.subway,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Следующий поезд через', style: TextStyle(fontSize: 14.0, color: Colors.black45)),
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
                    Text('${timeUntilNextTrain.minute}',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: color)),
                    Text('мин. ', style: TextStyle(fontSize: 18.0, color: Colors.black45, fontFamily: 'Futura')),
                    Text('${timeUntilNextTrain.second}',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: color)),
                    Text('сек.', style: TextStyle(fontSize: 18.0, color: Colors.black45, fontFamily: 'Futura')),
                  ],
          ),
        ],
      ),
    );
  }
}
