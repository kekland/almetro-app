import 'dart:async';

import 'package:almaty_metro/api/api.dart';
import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget {
  final Time time;
  final TextStyle style;
  final bool isNow;

  TimeDisplay({
    Key key,
    @required this.time,
    this.style,
    this.isNow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Text(
      time.toString(),
      style: Theme.of(context)
          .textTheme
          .headline6
          .copyWith(
            fontWeight: FontWeight.w600,
          )
          .merge(style),
    );

    if (!isNow) return text;

    return Row(
      children: [
        text,
        Spacer(),
        Text('сейчас', style: Theme.of(context).textTheme.caption),
      ],
    );
  }
}

class DurationDisplay extends StatelessWidget {
  final Duration duration;
  final TextStyle style;

  const DurationDisplay({
    Key key,
    @required this.duration,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final inSeconds = duration.inSeconds;
    final seconds = inSeconds % 60;
    final inMinutes = inSeconds ~/ 60;
    final minutes = inMinutes % 60;
    final hours = inMinutes ~/ 60;

    final isUrgent = inMinutes < 2;

    final numberStyle = style ??
        theme.textTheme.headline6.copyWith(
          fontWeight: FontWeight.w600,
          color: isUrgent ? theme.accentColor : null,
        );

    final captionStyle = theme.textTheme.caption;

    return Text.rich(
      TextSpan(
        children: [
          if (hours > 0) ...[
            TextSpan(text: hours.toString(), style: numberStyle),
            TextSpan(text: 'час  ', style: captionStyle),
          ],
          TextSpan(text: minutes.toString(), style: numberStyle),
          TextSpan(text: 'мин  ', style: captionStyle),
          TextSpan(text: seconds.toString(), style: numberStyle),
          TextSpan(text: 'сек', style: captionStyle)
        ],
      ),
    );
  }
}

class ClosestTimeDisplay extends StatefulWidget {
  final List<Time> schedule;
  final bool displayDuration;

  const ClosestTimeDisplay({
    Key key,
    @required this.schedule,
    this.displayDuration = false,
  }) : super(key: key);

  @override
  _ClosestTimeDisplayState createState() => _ClosestTimeDisplayState();
}

class _ClosestTimeDisplayState extends State<ClosestTimeDisplay> {
  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nowTime = Time.now();
    final closestTime = widget.schedule.firstWhere((v) => v > nowTime);

    return widget.displayDuration
        ? DurationDisplay(
            duration: nowTime.difference(closestTime),
          )
        : TimeDisplay(
            time: closestTime,
          );
  }
}
