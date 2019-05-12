
import 'package:flutter/material.dart';

class MainPageBackground extends StatefulWidget {
  @override
  _MainPageBackgroundState createState() => _MainPageBackgroundState();
}

class _MainPageBackgroundState extends State<MainPageBackground> {
  int index = -1;
  List<Color> colors = [
    Colors.pink,
    Colors.red,
  ];

  List<List<Color>> allColors = [
    [
      Colors.pink,
      Colors.red,
    ],
    [
      Colors.pink,
      Colors.redAccent,
    ],
    [
      Colors.red,
      Colors.redAccent,
    ],
    [
      Colors.red,
      Colors.pink,
    ],
    [
      Colors.red,
      Colors.redAccent,
    ],
    [
      Colors.pink,
      Colors.redAccent,
    ],
    [
      Colors.pink,
      Colors.red,
    ],
  ];

  void changeColors() {
    index++;
    if (index >= allColors.length) {
      index = 0;
    }
    setState(() {
      colors = allColors[index];
      Future.delayed(Duration(milliseconds: 1000), changeColors);
    });
  }

  @override
  void initState() {
    super.initState();

   // changeColors();
  }

  @override
  Widget build(BuildContext context) {
    /*return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
    );*/

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red.shade500,
      ),
    );
  }
}