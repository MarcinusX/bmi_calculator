import 'dart:math' as math;

import 'package:bmi_calculator/card_title.dart';
import 'package:flutter/material.dart';

class GenderCard extends StatefulWidget {
  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CardTitle("GENDER"),
              _drawIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _drawCircle(size: 80.0),
        _drawRotatedArrow(length: 32.0, angle: -43.0),
      ],
    );
  }

  Widget _drawCircle({double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(244, 244, 244, 1.0),
      ),
    );
  }

  Widget _drawRotatedArrow({double length, double angle}) {
    return Transform.rotate(
      angle: _degreeToRadians(angle),
      child: _drawCenteredArrow(length: length),
    );
  }

  Widget _drawCenteredArrow({double length}) {
    return Transform.translate(
      offset: Offset(0.0, -length / 2),
      child: _drawArrow(length: length),
    );
  }

  Widget _drawArrow({double length}) {
    double defaultRotationFromAsset = 43.0;
    return Transform.rotate(
      angle: _degreeToRadians(-defaultRotationFromAsset),
      child: Image.asset(
        "images/gender_indicator.png",
        height: length,
      ),
    );
  }

  double _degreeToRadians(double angle) {
    return angle * math.pi / 180;
  }
}
