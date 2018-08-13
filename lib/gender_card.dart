import 'dart:math' as math;

import 'package:bmi_calculator/card_title.dart';
import 'package:bmi_calculator/gender.dart';
import 'package:flutter/material.dart';

class GenderCard extends StatefulWidget {
  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  static final double _circleSize = 80.0;
  static final double _arrowLength = 32.0;
  static final double _defaultGenderAngle = 43.0;
  static final Map<Gender, double> _genderAngles = {
    Gender.female: -_defaultGenderAngle,
    Gender.other: 0.0,
    Gender.male: _defaultGenderAngle,
  };
  static final Map<Gender, String> _genderImages = {
    Gender.female: "images/gender_female.png",
    Gender.other: "images/gender_other.png",
    Gender.male: "images/gender_male.png",
  };

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
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: _drawMainStack(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawGenderIcon(Gender gender) {
    double angleInRadians = _degreeToRadians(_genderAngles[gender]);
    String assetName = _genderImages[gender];
    double iconHeight = gender == Gender.other ? 22.0 : 16.0;
    return Padding(
      padding: EdgeInsets.only(bottom: _circleSize / 2),
      child: Transform.rotate(
        alignment: Alignment.bottomCenter,
        angle: angleInRadians,
        child: Padding(
          padding: EdgeInsets.only(bottom: _circleSize / 2 + 24.0),
          child: Transform.rotate(
            angle: -angleInRadians,
            child: Image.asset(
              assetName,
              height: iconHeight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawMainStack() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _drawCircleIndicator(),
        _drawGenderIcon(Gender.female),
        _drawGenderIcon(Gender.other),
        _drawGenderIcon(Gender.male),
      ],
    );
  }

  Widget _drawCircleIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _drawCircle(),
        _drawRotatedArrow(angle: -43.0),
      ],
    );
  }

  Widget _drawCircle() {
    return Container(
      width: _circleSize,
      height: _circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(244, 244, 244, 1.0),
      ),
    );
  }

  Widget _drawRotatedArrow({double angle}) {
    return Transform.rotate(
      angle: _degreeToRadians(angle),
      child: _drawCenteredArrow(),
    );
  }

  Widget _drawCenteredArrow() {
    return Transform.translate(
      offset: Offset(0.0, -_arrowLength * 0.4),
      child: _drawArrow(),
    );
  }

  Widget _drawArrow() {
    return Transform.rotate(
      angle: _degreeToRadians(-_defaultGenderAngle),
      child: Image.asset(
        "images/gender_indicator.png",
        height: _arrowLength,
      ),
    );
  }

  double _degreeToRadians(double angle) {
    return angle * math.pi / 180;
  }
}
