import 'package:flutter/widgets.dart';

class AppLogo extends StatelessWidget {
  final double height;

  const AppLogo({
    Key key,
    @required this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icon-raster.png',
      height: 24.0,
    );
  }
}
