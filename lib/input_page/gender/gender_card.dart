import 'package:bmi_calculator/input_page/card_title.dart';
import 'package:bmi_calculator/input_page/gender/gender_arrow.dart';
import 'package:bmi_calculator/input_page/gender/gender_circle.dart';
import 'package:bmi_calculator/input_page/gender/gender_icon.dart';
import 'package:bmi_calculator/input_page/gender/gender_styles.dart';
import 'package:bmi_calculator/model/gender.dart';
import 'package:bmi_calculator/widget_utils.dart' show screenAwareSize;
import 'package:flutter/material.dart';

class GenderCard extends StatefulWidget {
  final Gender gender;
  final ValueChanged<Gender> onChanged;

  const GenderCard({
    Key key,
    this.gender = Gender.other,
    this.onChanged,
  }) : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard>
    with SingleTickerProviderStateMixin {
  AnimationController _arrowAnimationController;

  @override
  void initState() {
    _arrowAnimationController = new AnimationController(
      vsync: this,
      lowerBound: -defaultGenderAngle,
      upperBound: defaultGenderAngle,
      value: genderAngles[widget.gender],
    );
    super.initState();
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: screenAwareSize(16.0, context),
        right: screenAwareSize(4.0, context),
        bottom: screenAwareSize(4.0, context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CardTitle("GENDER"),
          Padding(
            padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
            child: _drawMainStack(),
          ),
        ],
      ),
    );
  }

  Widget _drawMainStack() {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _drawCircleIndicator(),
          GenderIconTranslated(
            gender: Gender.female,
            isSelected: widget.gender == Gender.female,
          ),
          GenderIconTranslated(
            gender: Gender.other,
            isSelected: widget.gender == Gender.other,
          ),
          GenderIconTranslated(
            gender: Gender.male,
            isSelected: widget.gender == Gender.male,
          ),
          _drawGestureDetector(),
        ],
      ),
    );
  }

  Widget _drawCircleIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GenderCircle(),
        GenderArrow(listenable: _arrowAnimationController),
      ],
    );
  }

  _drawGestureDetector() {
    return Positioned.fill(
      child: TapHandler(
        onGenderTapped: _setSelectedGender,
      ),
    );
  }

  void _setSelectedGender(Gender gender) {
    widget.onChanged(gender);
    _arrowAnimationController.animateTo(
      genderAngles[gender],
      duration: Duration(milliseconds: 150),
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
