import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AlmetroTextStyle {
  static TextStyle base = TextStyle(
    color: Colors.black,
    fontFamily: 'Futura',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  static TextStyle title = base.copyWith(
    fontSize: 24.0,
    fontFamily: 'Futura',
    fontWeight: FontWeight.w500,
  );
}
