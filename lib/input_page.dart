import 'package:bmi_calculator/gender/gender.dart';
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
            _buildSummaryCard(context),
            Expanded(child: _buildCards(context)),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenAwareSize(0.0, context)),
      child: InputSummaryCard(
        gender: Gender.male,
        weight: 72,
        height: 173,
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 14.0,
        right: 14.0,
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
    return Material(
      elevation: 1.0,
      child: Container(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputSummaryCard extends StatelessWidget {
  final Gender gender;
  final int height;
  final int weight;

  const InputSummaryCard({Key key, this.gender, this.height, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(screenAwareSize(16.0, context)),
      child: SizedBox(
        height: screenAwareSize(32.0, context),
        child: Row(
          children: <Widget>[
            Expanded(child: _genderText()),
            _divider(),
            Expanded(child: _text("${weight}kg")),
            _divider(),
            Expanded(child: _text("${height}cm")),
          ],
        ),
      ),
    );
  }

  Widget _genderText() {
    String genderText = gender == Gender.other
        ? '-'
        : (gender == Gender.male ? 'Male' : 'Female');
    return _text(genderText);
  }

  Widget _text(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(143, 144, 156, 1.0),
        fontSize: 15.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _divider() {
    return Container(
      width: 1.0,
      color: Color.fromRGBO(151, 151, 151, 0.1),
    );
  }
}
