import 'package:flutter/material.dart';

class ArrivalsPage extends StatefulWidget {
  const ArrivalsPage({Key key}) : super(key: key);
  @override
  _ArrivalsPageState createState() => _ArrivalsPageState();
}

class _ArrivalsPageState extends State<ArrivalsPage> with AutomaticKeepAliveClientMixin<ArrivalsPage> {
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Text('hi'),
    );
  }
}