import 'dart:math' as math;

import 'package:bmi_calculator/card_title.dart';
import 'package:bmi_calculator/gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderCard extends StatefulWidget {
  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  static final double _circleSize = 80.0;
  static final double _arrowLength = 32.0;
  static final double _defaultGenderAngle = 45.0;
  static final Map<Gender, double> _genderAngles = {
    Gender.female: -_defaultGenderAngle,
    Gender.other: 0.0,
    Gender.male: _defaultGenderAngle,
  };
  static final Map<Gender, String> _genderImages = {
    Gender.female: "images/gender_female.svg",
    Gender.other: "images/gender_other.svg",
    Gender.male: "images/gender_male.svg",
  };

  Gender selectedGender = Gender.female;

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
    double iconSize = gender == Gender.other ? 22.0 : 16.0;
    double genderLeftPadding = gender == Gender.other ? 8.0 : 0.0;
    return Padding(
      padding: EdgeInsets.only(bottom: _circleSize / 2),
      child: Transform.rotate(
        alignment: Alignment.bottomCenter,
        angle: angleInRadians,
        child: Padding(
          padding: EdgeInsets.only(bottom: _circleSize / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: -angleInRadians,
                child: Padding(
                  padding: EdgeInsets.only(left: genderLeftPadding),
                  child: SvgPicture.asset(
                    assetName,
                    height: iconSize,
                    width: iconSize,
                  ),
                ),
              ),
              GenderLine(),
            ],
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
        _drawRotatedArrow(angle: _genderAngles[selectedGender]),
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
    //we need to move arrow up for ~50% of its size since now it the middle of he arrow is in the middle of the circle;
    double translationOffset = -_arrowLength * 0.5;
    //we want to have the "pin" of the arrow in the middle, not the bottom of it, so we need to move it a bit down and adjust rotation alignment
    double adjustmentOffset = 0.1;
    translationOffset += adjustmentOffset * _arrowLength;

    return Transform.rotate(
      angle: _degreeToRadians(angle),
      alignment: Alignment(0.0, 0.0),
      child: Transform.translate(
        offset: Offset(0.0, translationOffset),
        child: _drawArrow(),
      ),
    );
  }

  Widget _drawArrow() {
    return Transform.rotate(
      angle: _degreeToRadians(-_defaultGenderAngle),
      child: SvgPicture.asset(
        "images/gender_arrow.svg",
        height: _arrowLength,
        width: _arrowLength,
      ),
    );
  }

  double _degreeToRadians(double angle) {
    return angle * math.pi / 180;
  }
}

class GenderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, top: 8.0),
      child: Container(
        height: 8.0,
        width: 1.0,
        color: Color.fromRGBO(216, 217, 223, 0.36),
      ),
    );
  }
}
