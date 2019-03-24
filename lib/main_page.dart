import 'package:almaty_metro/bottom_panel.dart';
import 'package:flutter/material.dart';

class MainPageBackground extends StatelessWidget {
  final Widget child;

  const MainPageBackground({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red,
            Colors.pink,
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: child,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPageBackground(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: BottomPanel(),
            ),
          ],
        ),
      ),
    );
  }
}
