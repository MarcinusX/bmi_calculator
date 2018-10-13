import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';

class PacManSlider extends StatefulWidget {
  @override
  _PacManSliderState createState() => _PacManSliderState();
}

class _PacManSliderState extends State<PacManSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenAwareSize(52.0, context),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
