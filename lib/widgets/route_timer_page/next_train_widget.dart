import 'package:almaty_metro/api/time.dart';
import 'package:almaty_metro/widgets/route_timer_page/time_widget.dart';
import 'package:almaty_metro/widgets/shared/icon_content_widget.dart';
import 'package:flutter/material.dart';

class NextTrainWidget extends StatefulWidget {
  final String title;
  final List<Time> nextTrains;
  final IconData icon;

  const NextTrainWidget({Key key, this.title, this.nextTrains, this.icon})
      : super(key: key);

  @override
  _NextTrainWidgetState createState() => _NextTrainWidgetState();
}

class _NextTrainWidgetState extends State<NextTrainWidget> {
  bool expanded = true;
  @override
  Widget build(BuildContext context) {
    return IconContentWidget(
      icon: widget.icon,
      onTap: () => setState(() => expanded = !expanded),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,
              style: TextStyle(fontSize: 14.0, color: Colors.black45)),
          if (widget.nextTrains == null)
            TimeWidget(time: null)
          else ...[
            TimeWidget(time: widget.nextTrains[0]),
            if (expanded) ...[
              SizedBox(height: 8.0),
              Opacity(
                  opacity: 0.5, child: TimeWidget(time: widget.nextTrains[1])),
              SizedBox(height: 8.0),
              Opacity(
                  opacity: 0.25, child: TimeWidget(time: widget.nextTrains[2])),
            ],
          ],
        ],
      ),
    );
  }
}
