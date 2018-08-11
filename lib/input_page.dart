import 'package:bmi_calculator/gender_card.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: MediaQuery.of(context).padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(),
            _buildCards(),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 80.0),
      child: Text(
        "BMI Calculator",
        style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  _buildCards() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 32.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GenderCard()
                  ),
                  Expanded(
                    child: Card(
                      child: Container(
                        width: double.infinity,
                        child: Text("Weight"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card(
                child: Container(
                  height: double.infinity,
                  child: Text("Height"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBottom() {
    return Container(
      alignment: Alignment.center,
      height: 108.0,
      width: double.infinity,
      child: Switch(value: true, onChanged: (val){}),
    );
  }
}
