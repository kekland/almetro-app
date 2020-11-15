import 'dart:math';

import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Future<void> showFeatureDiscoveryDialog({
  @required BuildContext context,
  @required Widget child,
  @required Offset offset,
  @required Size size,
  @required String title,
  @required String description,
}) {
  final mediaQuery = MediaQuery.of(context);
  final isOnTop = (offset.dy - mediaQuery.viewPadding.top) >= 72.0;

  final isOnLeft = offset.dx <= mediaQuery.size.width / 2.0;
  final textAlign = isOnLeft ? TextAlign.left : TextAlign.right;

  final descriptionWidget = SizedBox(
    width: max(size.width, mediaQuery.size.width * 0.6),
    height: 96.0,
    child: Column(
      crossAxisAlignment:
          isOnLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.white,
              ),
        )
      ],
    ),
  );

  return Navigator.of(context).push(
    FeatureDiscoveryPageRoute(
      center: offset + Offset(size.width / 2.0, size.height / 2.0),
      child: Stack(
        children: [
          Positioned(
            left: offset.dx,
            top: offset.dy,
            child: SizedBox.fromSize(
              child: (size.width < 100.0 && size.height < 100.0)
                  ? Container(
                      width: size.width,
                      height: size.height,
                      child: child,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  : child,
              size: size,
            ),
          ),
          Positioned(
            top: offset.dy + (isOnTop ? -64.0 : 64.0),
            left: isOnLeft ? offset.dx : null,
            right: isOnLeft
                ? null
                : mediaQuery.size.width - (offset.dx + size.width),
            child: descriptionWidget,
          ),
        ],
      ),
    ),
  );
}

class FeatureDiscoveryPageRoute extends PageRoute {
  final Widget child;
  final Offset center;

  FeatureDiscoveryPageRoute({
    @required this.child,
    @required this.center,
  });

  @SemanticsHintOverrides()
  Color get barrierColor => Colors.black54;

  @override
  String get barrierLabel => 'feature-discovery';

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final containerSize = MediaQuery.of(context).size.width * 1.5;

    return Material(
      type: MaterialType.transparency,
      child: Listener(
        onPointerUp: (v) => Navigator.pop(context),
        child: Stack(
          children: [
            Transform.translate(
              offset: center - Offset(50, 50),
              child: Transform.scale(
                scale: containerSize / 100.0,
                child: CircularRevealAnimation(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withOpacity(0.75),
                      shape: BoxShape.circle,
                    ),
                  ),
                  animation: animation,
                ),
              ),
            ),
            AbsorbPointer(child: child),
          ],
        ),
      ),
    );
  }

  @override
  bool get opaque => false;

  @override
  bool get maintainState => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);
}
