
import 'package:flutter/material.dart';

class StationCircle extends StatelessWidget {
  final bool activated;

  const StationCircle({Key key, this.activated = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.0,
      height: 16.0,
      decoration: BoxDecoration(
        color: (activated) ? Colors.red : Colors.black.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}