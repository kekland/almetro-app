import 'package:almaty_metro/design/almetro_design.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.0,
      color: AlmetroColor.captionColor,
    );
  }
}