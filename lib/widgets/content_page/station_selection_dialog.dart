import 'package:almaty_metro/api/stations.dart';
import 'package:almaty_metro/design/almetro_design.dart';
import 'package:almaty_metro/widgets/content_page/station_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StationSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StaggeredGridView.countBuilder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: MetroData.stations.length,
            physics: BouncingScrollPhysics(),
            reverse: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            staggeredTileBuilder: (_) => StaggeredTile.fit(
                  (MediaQuery.of(context).size.shortestSide < 320.0) ? 2 : 1,
                ),
            itemBuilder: (_, i) => StationWidget(
                  stationName: MetroData.stations[i],
                  onTap: () {
                    Navigator.of(context).pop(i);
                  },
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: CardWidget(
            fluid: true,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                  color: Colors.black,
                ),
                Expanded(
                    child: Text('Выберите станцию',
                        style: AlmetroTextStyle.title)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
