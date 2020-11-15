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
            color: Theme.of(context).accentColor,
            onPressed: canSwipeLeft
                ? () {
                    model.selectedStation = model
                        .subwayLine.stations[model.selectedStationIndex - 1];
                  }
                : null,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Станция',
                  style: theme.textTheme.caption,
                ),
                Text(
                  model.selectedStation.name,
                  style: theme.textTheme.headline6.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            color: Theme.of(context).accentColor,
            onPressed: canSwipeRight
                ? () {
                    model.selectedStation = model
                        .subwayLine.stations[model.selectedStationIndex + 1];
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
