import 'package:almaty_metro/api/api.dart';
import 'package:almaty_metro/api/model/station.dart';
import 'package:almaty_metro/widgets/card.dart';
import 'package:almaty_metro/dialogs/dialog_header.dart';
import 'package:almaty_metro/widgets/item_grid.dart';
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
      final theme = Theme.of(context);
      final textTheme = theme.textTheme;

      final stationStyle = textTheme.headline6;

      final nowTime = Time.now();

      return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: ItemGrid(
                  builder: (width) => Wrap(
                    runSpacing: 12.0,
                    spacing: 12.0,
                    children: [
                      ...schedule.map(
                        (v) => SizedBox(
                          width: width,
                          child: CardWidget(
                            child: TimeDisplay(
                              time: v,
                              style: nowTime > v
                                  ? TextStyle(
                                      color: textTheme.headline6.color
                                          .withOpacity(0.5),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                        from.name,
                        style: stationStyle,
                      ),
                    ),
                    Icon(Icons.arrow_right),
                    Expanded(
                      flex: 1,
                      child: Text(
                        to.name,
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
    },
  );
}
