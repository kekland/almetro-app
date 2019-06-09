import 'package:almaty_metro/design/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class IconContentWidget extends StatelessWidget {
  final IconData icon;
  final Widget child;
  final VoidCallback onTap;

  const IconContentWidget({Key key, this.child, this.icon, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
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
        ),
      ),
    );
  }
}
