import 'package:bmi_calculator/card_title.dart';
import 'package:bmi_calculator/widget_utils.dart' show screenAwareSize;
import 'package:flutter/material.dart';

class WeightCard extends StatefulWidget {
  @override
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(12.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle("WEIGHT", subTitle: "(KG)"),
            Padding(
              padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
              child: _drawSlider(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawSlider() {
    return Container();
  }
}
