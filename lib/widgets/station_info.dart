import 'package:almaty_metro/l10n/localization.dart';
import 'package:almaty_metro/model/app_model.dart';
import 'package:almaty_metro/widgets/card.dart';
import 'package:almaty_metro/dialogs/schedule_info_dialog.dart';
import 'package:almaty_metro/widgets/time_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StationInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AppModel>();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...model.selectedStation.schedule
            .map(
              (k, v) => MapEntry(
                k,
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CardWidget(
                      child: Row(
                        children: [
                          SizedBox(width: 4.0),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    style: textTheme.caption,
                                    children: [
                                      if (context.l10n.locale.languageCode !=
                                          'kk')
                                        TextSpan(
                                          text:
                                              '${context.l10n.labelToStation} ',
                                        ),
                                      TextSpan(
                                        text: context.l10n.getSubwayStationName(
                                          model.subwayLine.getStationWithId(k),
                                        ),
                                        style: textTheme.bodyText1.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (context.l10n.locale.languageCode ==
                                          'kk')
                                        TextSpan(
                                          text:
                                              ' ${context.l10n.labelToStation}',
                                        ),
                                    ],
                                  ),
                                ),
                                ClosestTimeDisplay(
                                  schedule: v,
                                  displayDuration: true,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.info_outline),
                            onPressed: () {
                              showScheduleInfoDialog(
                                context: context,
                                from: model.selectedStation,
                                to: model.subwayLine.getStationWithId(k),
                                schedule: v,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
            .values
      ],
    );
  }
}
