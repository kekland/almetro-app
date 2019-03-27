import 'package:almaty_metro/bottom_panel/station_selector_new.dart';
import 'package:almaty_metro/card_widget.dart';
import 'package:flutter/material.dart';

//TODO: Rename when finished
class BottomPanelNew extends StatefulWidget {
  @override
  _BottomPanelNewState createState() => _BottomPanelNewState();
}

class _BottomPanelNewState extends State<BottomPanelNew> {
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      fluid: true,
      padding: EdgeInsets.zero,
      child: Container(
        child: StationSelectorNew(),
      ),
    );
  }
}