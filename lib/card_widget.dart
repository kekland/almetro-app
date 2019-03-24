import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback onClick;
  final bool fluid;
  /*
      duration: Duration(milliseconds: 750),
      curve: Curves.easeInOut,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12.0,
            offset: Offset(0.0, 6.0),
            spreadRadius: 0.0,
          ),
        ],
      ),*/

  const CardWidget({Key key, this.child, this.padding, this.onClick, this.fluid}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12.0,
            offset: Offset(0.0, 6.0),
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onClick,
          child: AnimatedSize(
            vsync: this,
            curve: Curves.elasticOut,
            duration: Duration(milliseconds: 800),
            child: Padding(padding: widget.padding, child: widget.child),
          ),
        ),
      ),
    );
  }
}
