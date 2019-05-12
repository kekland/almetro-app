import 'package:almaty_metro/widgets/main_page/app_bar.dart';
import 'package:almaty_metro/pages/content_page.dart';
import 'package:almaty_metro/widgets/main_page/background.dart';
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
                MetroBar(
                  title: 'Almetro',
                ),
                Expanded(
                  child: AppContentPage()
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
