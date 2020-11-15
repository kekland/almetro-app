import 'dart:math';

import 'package:almaty_metro/api/api.dart';
import 'package:almaty_metro/api/model/station.dart';
import 'package:almaty_metro/widgets/card.dart';
import 'package:almaty_metro/dialogs/dialog_header.dart';
import 'package:almaty_metro/widgets/time_display.dart';
import 'package:flutter/material.dart';

void showScheduleInfoDialog({
  BuildContext context,
  SubwayStation from,
  SubwayStation to,
  List<Time> schedule,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return _ScheduleInfoDialog(from: from, to: to, schedule: schedule);
    },
  );
}

class _ScheduleInfoDialog extends StatefulWidget {
  final SubwayStation from;
  final SubwayStation to;
  final List<Time> schedule;

  const _ScheduleInfoDialog({
    Key key,
    @required this.from,
    @required this.to,
    @required this.schedule,
  }) : super(key: key);

  @override
  __ScheduleInfoDialogState createState() => __ScheduleInfoDialogState();
}

class __ScheduleInfoDialogState extends State<_ScheduleInfoDialog> {
  final ScrollController _scrollController = ScrollController();
  final itemExtent = 60.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nowTime = Time.now();
      final closestTime = widget.schedule.firstWhere((v) => v > nowTime);
      final index = widget.schedule.indexOf(closestTime);

      _scrollController.animateTo(
        itemExtent * max(0, index - 3),
        duration: const Duration(milliseconds: 550),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final stationStyle = textTheme.headline6;

    final nowTime = Time.now();
    final closestTime = widget.schedule.firstWhere((v) => v > nowTime);

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              itemCount: widget.schedule.length,
              padding: const EdgeInsets.all(12.0),
              separatorBuilder: (_, i) => SizedBox(height: 12.0),
              itemBuilder: (context, i) {
                final time = widget.schedule[i];

                final isInFuture = time > nowTime;
                final isClosest = closestTime == time;

                return CardWidget(
                  child: TimeDisplay(
                    time: time,
                    isNow: isClosest,
                    style: !isInFuture
                        ? TextStyle(
                            color: textTheme.headline6.color.withOpacity(0.4),
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DialogHeader(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      widget.from.name,
                      style: stationStyle,
                    ),
                  ),
                  Icon(Icons.arrow_right),
                  Expanded(
                    flex: 1,
                    child: Text(
                      widget.to.name,
                      style: stationStyle,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(width: 12.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
