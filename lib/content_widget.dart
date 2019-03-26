import 'package:almaty_metro/arrivals_page/arrivals_page.dart';
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

  List<Widget> pages = [RouteTimerPage(), ArrivalsPage()];

  @override
  void initState() {
    pageViewController = PageController(keepPage: true, initialPage: 0);
    pageViewController.addListener(() {
      setState(() {
        currentPageAnimationValue = pageViewController.page;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageViewController,
      physics: BouncingScrollPhysics(),
      children: pages,
    );
  }
}
