import 'package:almaty_metro/api/time.dart';
import 'package:almaty_metro/widgets/shared/icon_content_widget.dart';
import 'package:flutter/material.dart';

class NextTrainWidget extends StatelessWidget {
  final String title;
  final Time timeUntilNextTrain;

  const NextTrainWidget({Key key, this.timeUntilNextTrain, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color color = (timeUntilNextTrain?.inSeconds() != null && timeUntilNextTrain.inSeconds() <= 60)
        ? Colors.red.shade700
        : Colors.black;
    return IconContentWidget(
      icon: Icons.subway,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (timeUntilNextTrain == null)
            ? [
                Text(title,
                    style: TextStyle(fontSize: 14.0, color: Colors.black45)),
                Text(
                  '-',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28.0,
                      color: color),
                )
              ]
            : [
                Text(title,
                    style: TextStyle(fontSize: 14.0, color: Colors.black45)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('${timeUntilNextTrain.minute}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 28.0,
                            color: color)),
                    Text('мин. ',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black45,
                            fontFamily: 'Futura')),
                    Text('${timeUntilNextTrain.second}',
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
                ),
              ],
      ),
    );
  }
}
