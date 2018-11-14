import 'dart:math' as math;

import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';

class TransitionDot extends AnimatedWidget {
  TransitionDot({Key key, Listenable animation})
      : super(key: key, listenable: animation);

  Animation<int> get positionAnimation => IntTween(
        begin: 0,
        end: 50,
      ).animate(
        CurvedAnimation(
          parent: super.listenable,
          curve: Interval(0.15, 0.3),
        ),
      );

  Animation<double> get sizeAnimation => LoopedSizeAnimation().animate(
        CurvedAnimation(
          parent: super.listenable,
          curve: Interval(0.3, 1.0),
        ),
      );

  @override
  Widget build(BuildContext context) {
    double scaledSize = screenAwareSize(sizeAnimation.value, context);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double height = math.min(scaledSize, deviceHeight);
    double width = math.min(scaledSize, deviceWidth);
    Decoration decoration = BoxDecoration(
      shape: width < 0.9 * deviceWidth ? BoxShape.circle : BoxShape.rectangle,
      color: Theme.of(context).primaryColor,
    );

    Widget dot = Container(
      decoration: decoration,
      width: width,
      height: height,
    );
    return IgnorePointer(
      child: Opacity(
        opacity: positionAnimation.value > 0 ? 1.0 : 0.0,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Spacer(flex: 104 - positionAnimation.value),
                dot,
                Spacer(flex: 4 + positionAnimation.value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoopedSizeAnimation extends Animatable<double> {
  final double defaultSize = 52.0;
  final double expansionRange = 30.0;
  final int numberOfCycles = 2;
  final double fullExpansionEdge = 0.8;

  @override
  double transform(double t) {
    if (t < fullExpansionEdge) {
      double normalizedT = t / fullExpansionEdge;
      return defaultSize +
          math.sin(numberOfCycles * 2 * math.pi * normalizedT) * expansionRange;
    } else {
      double normalizedT = (t - fullExpansionEdge) / (1 - fullExpansionEdge);
      return defaultSize + normalizedT * 2000.0;
    }
  }
}
