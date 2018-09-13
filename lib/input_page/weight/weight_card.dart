import 'package:bmi_calculator/input_page/card_title.dart';
import 'package:bmi_calculator/input_page/weight/weight_slider.dart';
import 'package:bmi_calculator/widget_utils.dart' show screenAwareSize;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeightCard extends StatelessWidget {
  final int weight;
  final ValueChanged<int> onChanged;

  const WeightCard({Key key, this.weight = 70, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: screenAwareSize(16.0, context),
        right: screenAwareSize(4.0, context),
        top: screenAwareSize(4.0, context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CardTitle("WEIGHT", subtitle: "(kg)"),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenAwareSize(16.0, context)),
                child: _drawSlider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawSlider() {
    return WeightBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.isTight
              ? Container()
              : WeightSlider(
                  minValue: 30,
                  maxValue: 110,
                  value: weight,
                  onChanged: (val) => onChanged(val),
                  width: constraints.maxWidth,
                );
        },
      ),
    );
  }
}

class WeightBackground extends StatelessWidget {
  final Widget child;

  const WeightBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: screenAwareSize(100.0, context),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius:
                new BorderRadius.circular(screenAwareSize(50.0, context)),
          ),
          child: child,
        ),
        SvgPicture.asset(
          "images/weight_arrow.svg",
          height: screenAwareSize(10.0, context),
          width: screenAwareSize(18.0, context),
        ),
      ],
    );
  }
}
