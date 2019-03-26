import 'package:almaty_metro/arrivals_page/arrivals_page.dart';
import 'package:almaty_metro/route_timer_page/bottom_panel.dart';
import 'package:almaty_metro/route_timer_page/route_timer_page.dart';
import 'package:flutter/material.dart';

class AppContentWidget extends StatefulWidget {
  @override
  _AppContentWidgetState createState() => _AppContentWidgetState();
}

class _AppContentWidgetState extends State<AppContentWidget> {
  PageController pageViewController;
  int initialPage = 0;
  double currentPageAnimationValue = 0;

  int _departureStationIndex = 0;
  int _arrivalStationIndex = 8;

  List<Widget> pages;

  Widget createRouteTimePage() {
    return RouteTimerPage(
      departureStationIndex: _departureStationIndex,
      arrivalStationIndex: _arrivalStationIndex,
    );
  }

  Widget createArrivalsPage() {
    return ArrivalsPage(
      departureStationIndex: _departureStationIndex,
      arrivalStationIndex: _arrivalStationIndex,
    );
  }

  @override
  void initState() {
    pageViewController = PageController(keepPage: true, initialPage: 0);

    pageViewController.addListener(() {
      setState(() {
        currentPageAnimationValue = pageViewController.page;
      });
    });

    pages = [
      createRouteTimePage(),
      createArrivalsPage(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            controller: pageViewController,
            physics: BouncingScrollPhysics(),
            children: pages,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: BottomPanel(
            onChange: (int departureStationIndex, int arrivalStationIndex) {
              setState(() {
                this._departureStationIndex = departureStationIndex;
                this._arrivalStationIndex = arrivalStationIndex;
              });
            },
          ),
        ),
      ],
    );
  }
}
