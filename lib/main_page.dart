import 'package:almaty_metro/app_bar.dart';
import 'package:almaty_metro/content_widget.dart';
import 'package:almaty_metro/main_page_background.dart';
import 'package:flutter/material.dart';
class MainPage extends StatelessWidget {
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
                  child: AppContentWidget()
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
