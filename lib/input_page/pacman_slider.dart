import 'dart:async';

import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PacManSlider extends StatefulWidget {
  @override
  _PacManSliderState createState() => _PacManSliderState();
}

class _PacManSliderState extends State<PacManSlider>
    with TickerProviderStateMixin {
  final int numberOfDots = 10;
  AnimationController hintAnimationController;

  @override
  void initState() {
    super.initState();
    _initHintAnimationController();
    hintAnimationController.forward();
  }

  @override
  void dispose() {
    hintAnimationController.dispose();
    super.dispose();
  }

  void _initHintAnimationController() {
    hintAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    hintAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 800), () {
          hintAnimationController.forward(from: 0.0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenAwareSize(52.0, context),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Theme.of(context).primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenAwareSize(24.0, context),
        ),
        child: Row(
          children: <Widget>[
            _drawPacman(),
            Expanded(child: _drawDots()),
          ],
        ),
      ),
    );
  }

  Widget _drawPacman() {
    return Padding(
      padding: EdgeInsets.only(
        right: screenAwareSize(16.0, context),
      ),
      child: SvgPicture.asset(
        'images/pacman.svg',
        height: screenAwareSize(25.0, context),
        width: screenAwareSize(21.0, context),
      ),
    );
  }

  Widget _drawDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(numberOfDots, _generateDot)
        ..add(Opacity(
          opacity: 0.5,
          child: _drawStaticDot(14.0),
        )),
    );
  }

  Widget _generateDot(int dotNumber) {
    Animation opacityAnimation = _initDotAnimation(dotNumber);
    return AnimatedBuilder(
      animation: opacityAnimation,
      builder: (context, child) => Opacity(
            opacity: _dotAnimationToOpacity(opacityAnimation),
            child: child,
          ),
      child: _drawStaticDot(9.0),
    );
  }

  Widget _drawStaticDot(double size) {
    return Container(
      height: screenAwareSize(size, context),
      width: screenAwareSize(size, context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }

  Animation<double> _initDotAnimation(int dotNumber) {
    double lastDotStartTime = 0.3;
    double dotAnimationDuration = 0.6;
    double begin = lastDotStartTime * dotNumber / numberOfDots;
    double end = begin + dotAnimationDuration;
    return Tween(begin: 0.0, end: 3.0).animate(
      CurvedAnimation(
        parent: hintAnimationController,
        curve: Interval(begin, end),
      ),
    );
  }

  double _dotAnimationToOpacity(Animation animation) {
    double minOpacity = 0.1;
    double maxOpacity = 0.5;
    if (animation.value < 1.0) {
      //dot gets brighter
      return minOpacity + animation.value * maxOpacity;
    } else if (animation.value < 2.0) {
      //dot remains bright
      return maxOpacity;
    } else {
      //dot gets darker
      return minOpacity + (maxOpacity - minOpacity) * (3.0 - animation.value);
    }
  }
}
