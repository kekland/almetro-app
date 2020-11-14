import 'package:almaty_metro/model/app_model.dart';
import 'package:almaty_metro/widgets/card.dart';
import 'package:almaty_metro/widgets/dialog_header.dart';
import 'package:almaty_metro/widgets/item_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showStationPickerDialog(BuildContext context) async {
  final model = context.read<AppModel>();

  final value = await showDialog(
    context: context,
    builder: (context) => SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ItemGrid(
                builder: (width) {
                  return Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: [
                      ...model.subwayLine.stations.map(
                        (station) => SizedBox(
                          width: width,
                          height: 64.0,
                          child: CardWidget(
                            onTap: () => Navigator.pop(context, station),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    station.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: model.selectedStation ==
                                                  station
                                              ? Theme.of(context).accentColor
                                              : null,
                                        ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: DialogHeader(
                  child: Text(
                    'Выберите станцию',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  if (value != null) {
    model.selectedStation = value;
  }
}
