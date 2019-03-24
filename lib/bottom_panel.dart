import 'package:almaty_metro/icon_text_widget.dart';
import 'package:almaty_metro/station_selector.dart';
import 'package:flutter/material.dart';

class BottomPanel extends StatefulWidget {
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 16.0,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10.0,
              offset: Offset(0.0, 3.0),
              spreadRadius: 1.0,
            ),
          ],
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconTextWidget(
              title: 'Москва',
              subtitle: 'Станция',
              icon: Icons.subway,
              isTop: true,
              onClick: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StationSelectorWidget();
                  },
                );
              },
            ),
            Container(
              width: double.infinity,
              height: 2.0,
              color: Colors.black.withOpacity(0.05),
            ),
            IconTextWidget(
                title: 'Театр им. Мухтара Ауэзова',
                subtitle: 'В сторону',
                icon: Icons.directions,
                isTop: false,
                onClick: () {}),
          ],
        ),
      ),
    );
  }
}
