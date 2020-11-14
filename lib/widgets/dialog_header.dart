import 'package:almaty_metro/widgets/card.dart';
import 'package:flutter/material.dart';

class DialogHeader extends StatelessWidget {
  final Widget child;

  const DialogHeader({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
