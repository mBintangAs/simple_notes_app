import 'package:flutter/material.dart';

class SwipeDetector extends StatelessWidget {
  final Widget child;
  final Function onSwipeLeft;
  final Function onSwipeRight;

  const SwipeDetector({
    required Key key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! < 0) {
          onSwipeLeft();
        } else if (details.primaryVelocity! > 0) {
          onSwipeRight();
        }
      },
      child: child,
    );
  }
}