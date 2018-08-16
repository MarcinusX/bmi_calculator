import 'dart:math' as math;

import 'package:bmi_calculator/card_title.dart';
import 'package:bmi_calculator/gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderCard extends StatefulWidget {
  @override
  _GenderCardState createState() => _GenderCardState();
}

const double _defaultGenderAngle = math.pi / 4;

class _GenderCardState extends State<GenderCard>
    with SingleTickerProviderStateMixin {
  static final double _circleSize = 80.0;
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

  AnimationController _arrowAnimationController;
  Gender selectedGender = Gender.female;

  @override
  void initState() {
    _arrowAnimationController = new AnimationController(
      vsync: this,
      lowerBound: -_defaultGenderAngle,
      upperBound: _defaultGenderAngle,
      value: _genderAngles[selectedGender],
    );
    super.initState();
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  void _setSelectedGender(Gender gender) {
    setState(() => selectedGender = gender);
    _arrowAnimationController.animateTo(_genderAngles[gender],
        duration: Duration(milliseconds: 150));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }

  Widget _drawGenderIcon(Gender gender) {
    String assetName = _genderImages[gender];
    double iconSize = gender == Gender.other ? 22.0 : 16.0;
    double genderLeftPadding = gender == Gender.other ? 8.0 : 0.0;
    return Padding(
      padding: EdgeInsets.only(bottom: _circleSize / 2),
      child: Transform.rotate(
        alignment: Alignment.bottomCenter,
        angle: _genderAngles[gender],
        child: Padding(
          padding: EdgeInsets.only(bottom: _circleSize / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: -_genderAngles[gender],
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
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _drawCircleIndicator(),
          _drawGenderIcon(Gender.female),
          _drawGenderIcon(Gender.other),
          _drawGenderIcon(Gender.male),
          _drawGestureDetector(),
        ],
      ),
    );
  }

  Widget _drawCircleIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _drawCircle(),
        AnimatedBuilder(
          builder: (context, child) =>
              GenderArrow(angle: _arrowAnimationController.value),
          animation: _arrowAnimationController,
        )
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

  _drawGestureDetector() {
    return Positioned.fill(
      child: TapHandler(
        onGenderTapped: _setSelectedGender,
      ),
    );
  }
}

class GenderArrow extends StatelessWidget {
  static final double _arrowLength = 32.0;
  static final double _translationOffset = _arrowLength * -0.4;

  final double angle;

  const GenderArrow({Key key, this.angle = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      alignment: Alignment(0.0, 0.0),
      child: Transform.translate(
        offset: Offset(0.0, _translationOffset),
        child: Transform.rotate(
          angle: -_defaultGenderAngle,
          child: SvgPicture.asset(
            "images/gender_arrow.svg",
            height: _arrowLength,
            width: _arrowLength,
          ),
        ),
      ),
    );
  }
}

class TapHandler extends StatelessWidget {
  final Function(Gender) onGenderTapped;

  const TapHandler({Key key, this.onGenderTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: GestureDetector(onTap: () => onGenderTapped(Gender.female))),
        Expanded(
            child: GestureDetector(onTap: () => onGenderTapped(Gender.other))),
        Expanded(
            child: GestureDetector(onTap: () => onGenderTapped(Gender.male))),
      ],
    );
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
