import 'package:bmi_calculator/gender/gender_card.dart';
import 'package:bmi_calculator/height/height_card.dart';
import 'package:bmi_calculator/weight/weight_card.dart';
import 'package:flutter/material.dart';

import 'widget_utils.dart' show screenAwareSize;

class InputPage extends StatelessWidget {
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).padding);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BmiAppBar(),
            _buildTitle(context),
            Expanded(child: _buildCards(context)),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.0,
        top: screenAwareSize(8.0, context),
      ),
      child: Text(
        "BMI Calculator",
        style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 14.0,
        right: 14.0,
        top: screenAwareSize(32.0, context),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: GenderCard()),
                Expanded(child: WeightCard()),
              ],
            ),
          ),
          Expanded(child: HeightCard())
        ],
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: screenAwareSize(108.0, context),
      width: double.infinity,
      child: Switch(value: true, onChanged: (val) {}),
    );
  }
}

class BmiAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenAwareSize(76.0, context),
        color: Colors.white,
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.all(screenAwareSize(16.0, context)),
          child: RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                text: "Hi Johny ",
                children: <TextSpan>[
                  TextSpan(
                    style: TextStyle(fontWeight: FontWeight.normal),
                    text: "\uD83D\uDC4B",
                  )
                ]),
          ),
        ));
  }
}
