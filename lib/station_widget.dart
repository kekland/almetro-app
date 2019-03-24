import 'package:flutter/material.dart';
import 'package:almaty_metro/stations.dart' as data;

class StationWidget extends StatelessWidget {
  final String name;

  const StationWidget({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black.withOpacity(0.06),
            width: 2.0,
          ),
        ),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
