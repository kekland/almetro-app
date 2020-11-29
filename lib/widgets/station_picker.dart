import 'package:almaty_metro/l10n/localization.dart';
import 'package:almaty_metro/model/app_model.dart';
import 'package:almaty_metro/widgets/card.dart';
import 'package:almaty_metro/dialogs/station_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StationPicker extends StatelessWidget {
  const StationPicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = context.watch<AppModel>();

    final canSwipeLeft = model.selectedStationIndex > 0;
    final canSwipeRight = model.selectedStationIndex < model.stationsLength - 1;

    return CardWidget(
      onTap: () => showStationPickerDialog(context),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            color: canSwipeLeft
                ? Theme.of(context).accentColor
                : Theme.of(context).disabledColor,
            splashRadius: canSwipeLeft ? null : 0.1,
            onPressed: canSwipeLeft
                ? () {
                    model.selectedStation = model
                        .subwayLine.stations[model.selectedStationIndex - 1];
                  }
                : () {},
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.labelStation,
                  style: theme.textTheme.caption,
                ),
                Text(
                  context.l10n.getSubwayStationName(model.selectedStation),
                  style: theme.textTheme.headline6.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            color: canSwipeRight
                ? Theme.of(context).accentColor
                : Theme.of(context).disabledColor,
            splashRadius: canSwipeRight ? null : 0.1,
            onPressed: canSwipeRight
                ? () {
                    model.selectedStation = model
                        .subwayLine.stations[model.selectedStationIndex + 1];
                  }
                : () {},
          ),
        ],
      ),
    );
  }
}
