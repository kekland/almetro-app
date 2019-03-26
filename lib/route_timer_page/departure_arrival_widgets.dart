import 'package:almaty_metro/icon_content_widget.dart';
import 'package:almaty_metro/time.dart';
import 'package:almaty_metro/time_calculator.dart';
import 'package:flutter/material.dart';

class DepartureTimeWidget extends StatelessWidget {
  final int arrivalStationIndex;
  final int departureStationIndex;
  final DateTime departureTime;

  const DepartureTimeWidget({Key key, this.arrivalStationIndex, this.departureStationIndex, this.departureTime})
      : super(key: key);

  Widget _buildTime() {
    Color color = Colors.black;
    return (arrivalStationIndex == departureStationIndex)
        ? Text(
            '-',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: color),
          )
        : Text(
            '${dateTimeToHourOfDayString(departureTime)}',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: color),
          );
  }

  @override
  Widget build(BuildContext context) {
    return IconContentWidget(
      icon: Icons.departure_board,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Время отьезда', style: TextStyle(fontSize: 16.0, color: Colors.black45)),
          _buildTime(),
        ],
      ),
    );
  }
}

class ArrivalTimeWidget extends StatelessWidget {
  final int arrivalStationIndex;
  final int departureStationIndex;
  final DateTime departureTime;

  const ArrivalTimeWidget({Key key, this.arrivalStationIndex, this.departureStationIndex, this.departureTime})
      : super(key: key);

  Widget _buildTime() {
    DateTime arrivalTime =
        departureTime.add(getTimeBetweenTwoStations(from: arrivalStationIndex, to: departureStationIndex));
    Color color = Colors.black;
    return (arrivalStationIndex == departureStationIndex)
        ? Text(
            '-',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: color),
          )
        : Text(
            '${dateTimeToHourOfDayString(arrivalTime)}',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0, color: color),
          );
  }

  @override
  Widget build(BuildContext context) {
    return IconContentWidget(
      icon: Icons.transit_enterexit,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Время прибытия', style: TextStyle(fontSize: 16.0, color: Colors.black45)),
          _buildTime(),
        ],
      ),
    );
  }
}
