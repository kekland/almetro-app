import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

class CircularRevealPageRoute extends PageRoute {
  final WidgetBuilder builder;

  CircularRevealPageRoute({@required this.builder});

  @override
  String get barrierLabel => 'feature-discovery';

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final child = builder(context);
    return CircularRevealAnimation(
      child: child,
      animation: animation,
      centerAlignment: Alignment.bottomCenter,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  Color get barrierColor => null;

  @override
  bool get maintainState => false;
}
