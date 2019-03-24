import 'package:swipedetector/swipedetector.dart';
import 'package:flutter/material.dart';

class IconTextWidget extends StatefulWidget {
  final bool isTop;
  final String subtitle;
  final String title;
  final IconData icon;
  final VoidCallback onLeftPress;
  final VoidCallback onRightPress;

  const IconTextWidget({
    Key key,
    this.subtitle,
    this.title,
    this.icon,
    this.isTop,
    this.onLeftPress,
    this.onRightPress,
  }) : super(key: key);

  @override
  _IconTextWidgetState createState() => _IconTextWidgetState();
}

class _IconTextWidgetState extends State<IconTextWidget> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  String _oldTitle = null;
  String _newTitle = null;
  bool _animationFromLeft = true;

  _clickLeft() {
    _animationFromLeft = true;
    widget.onLeftPress();
  }

  _clickRight() {
    _animationFromLeft = false;
    widget.onRightPress();
  }

  @override
  void didUpdateWidget(IconTextWidget oldWidget) {
    if (widget.title != oldWidget.title) {
      _newTitle = widget.title;
      _oldTitle = oldWidget.title;

      controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    controller = new AnimationController(duration: Duration(milliseconds: 250), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _oldTitle = null;
        controller.reset();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeRight: (widget.onLeftPress != null)? _clickLeft : null,
      onSwipeLeft: (widget.onRightPress != null)? _clickRight : null,
      swipeConfiguration: SwipeConfiguration(
        horizontalSwipeMaxHeightThreshold: 50.0,
        horizontalSwipeMinDisplacement:25.0,
        horizontalSwipeMinVelocity: 150.0
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left, size: 32.0),
              onPressed: (widget.onLeftPress != null)? _clickLeft : null,
              disabledColor: Colors.black.withOpacity(0.12),
              color: Colors.red,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.subtitle),
                  Stack(
                    children: [
                      Opacity(
                        opacity: 1.0 - animation.value,
                        child: Text(
                          (_oldTitle != null) ? _oldTitle : widget.title,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: animation.value,
                        child: Transform(
                          transform: Matrix4.translationValues(
                            -50.0 * (1.0 - animation.value) * (_animationFromLeft ? 1 : -1),
                            0.0,
                            0.0,
                          ),
                          child: Text(
                            (_newTitle != null) ? _newTitle : "",
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            IconButton(
              icon: Icon(Icons.chevron_right, size: 32.0),
              onPressed: (widget.onRightPress != null)? _clickRight : null,
              disabledColor: Colors.black.withOpacity(0.12),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
