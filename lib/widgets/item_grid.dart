import 'package:flutter/widgets.dart';

class ItemGrid extends StatelessWidget {
  final Widget Function(double width) builder;

  const ItemGrid({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final rowLength = (width / 180.0).floor();

        final itemWidth = ((width - (rowLength - 1) * 12.0) / rowLength);

        return builder(itemWidth);
      },
    );
  }
}
