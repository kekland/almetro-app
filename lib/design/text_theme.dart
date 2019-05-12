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

  static TextStyle caption = base.copyWith(
    fontSize: 14.0,
    color: Colors.black45,
  );

  static TextStyle boldInformation = base.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 28.0,
    color: Colors.black,
    fontFamily: 'Roboto'
  );
  
  static TextStyle boldInformationNumber = base.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 28.0,
    color: Colors.black,
    fontFamily: 'Days'
  );
}
