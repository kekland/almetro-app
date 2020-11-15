import 'package:flutter/widgets.dart';

class FocusableItem extends StatefulWidget {
  final Widget child;
  final bool focus;

  const FocusableItem({
    Key key,
    @required this.child,
    this.focus = false,
  }) : super(key: key);
  @override
  _FocusableItemState createState() => _FocusableItemState();
}

class _FocusableItemState extends State<FocusableItem> {
  @override
  void initState() {
    super.initState();

    if (widget.focus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.findRenderObject().showOnScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
