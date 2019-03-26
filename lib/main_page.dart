import 'package:almaty_metro/app_bar.dart';
import 'package:almaty_metro/info_page/info_page.dart';
import 'package:almaty_metro/main_page_background.dart';
import 'package:almaty_metro/route_timer_page/route_timer_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MainPageBackground(),
          SafeArea(
            child: Column(
              children: <Widget>[
                MetroBar(),
                Expanded(
                  child: RouteTimerPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
