import 'package:almaty_metro/widgets/feature_discovery/feature_discovery_dialog.dart';
import 'package:flutter/widgets.dart';

class DiscoverableFeature extends StatefulWidget {
  final Widget child;
  final String title;
  final String description;
  final String featureKey;

  const DiscoverableFeature({
    Key key,
    @required this.child,
    @required this.title,
    @required this.description,
    @required this.featureKey,
  }) : super(key: key);

  @override
  DiscoverableFeatureState createState() => DiscoverableFeatureState();
}

class DiscoverableFeatureState extends State<DiscoverableFeature> {
  Future<void> show() {
    final renderBox = context.findRenderObject() as RenderBox;
    final translation = renderBox.getTransformTo(null).getTranslation();
    final paintBounds = renderBox.paintBounds.shift(
      Offset(translation.x, translation.y),
    );

    return showFeatureDiscoveryDialog(
      context: context,
      child: widget.child,
      title: widget.title,
      description: widget.description,
      offset: paintBounds.topLeft,
      size: paintBounds.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
