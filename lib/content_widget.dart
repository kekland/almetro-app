import 'package:almaty_metro/arrivals_page/arrivals_page.dart';
import 'package:almaty_metro/route_timer_page/route_timer_page.dart';
import 'package:flutter/material.dart';

class AppContentWidget extends StatefulWidget {
  @override
  _AppContentWidgetState createState() => _AppContentWidgetState();
}

class _AppContentWidgetState extends State<AppContentWidget> {
  PageController pageViewController;

  @override
  void initState() {
    pageViewController = PageController(keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: BouncingScrollPhysics(),
      controller: pageViewController,
      children: [
        RouteTimerPage(),
        ArrivalsPage(),
      ],
    );
  }
}
