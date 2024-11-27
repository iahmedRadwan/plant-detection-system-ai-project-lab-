import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomOnBoardingAnimatedWidget extends StatelessWidget {
  final int index;
  final int delay;
  final Widget child;

  const CustomOnBoardingAnimatedWidget(
      {super.key,
        required this.index,
        required this.delay,
        required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,

    );
  }
}