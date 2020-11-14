import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final bool isHidden;
  final VoidCallback onTap;

  const CardWidget({
    Key key,
    @required this.child,
    this.isHidden = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12.0);
    return Container(
      child: Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: child,
          ),
        ),
      ),
      decoration: isHidden
          ? null
          : BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 12.0,
                ),
              ],
            ),
    );
  }
}
