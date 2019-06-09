import 'package:almaty_metro/api/time.dart';
import 'package:almaty_metro/widgets/route_timer_page/time_widget.dart';
import 'package:almaty_metro/widgets/shared/icon_content_widget.dart';
import 'package:flutter/material.dart';

class NextTrainWidget extends StatelessWidget {
  final String title;
  final Time timeUntilNextTrain;

  const NextTrainWidget({Key key, this.timeUntilNextTrain, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconContentWidget(
      icon: Icons.subway,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14.0, color: Colors.black45)),
          TimeWidget(time: timeUntilNextTrain),
        ],
      ),
    );
  }
}
