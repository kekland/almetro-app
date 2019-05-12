import 'package:almaty_metro/design/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class IconContentWidget extends StatelessWidget {
  final IconData icon;
  final Widget child;

  const IconContentWidget({Key key, this.child, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 36.0,
            color: Colors.black45,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}