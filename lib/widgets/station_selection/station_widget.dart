import 'package:almaty_metro/design/almetro_design.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StationWidget extends StatelessWidget {
  final String stationName;
  final bool isSelected;
  final VoidCallback onTap;

  const StationWidget({Key key, this.stationName, this.onTap, this.isSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      fluid: false,
      padding: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(FontAwesomeIcons.subway,
                  color: AlmetroColor.captionIconColor),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      (isSelected) ? 'Выбранная станция' : 'Станция',
                      style: AlmetroTextStyle.caption,
                    ),
                    Text(
                      stationName,
                      style: AlmetroTextStyle.boldInformation.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                          color: (isSelected) ? Colors.black45 : Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
