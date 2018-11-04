import 'package:bmi_calculator/input_page/app_bar.dart';
import 'package:bmi_calculator/input_page/input_page_styles.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: BmiAppBar(),
        preferredSize: Size.fromHeight(appBarHeight(context)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[ResultCard(), _buildBottomBar()],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.grey,
                size: 28.0,
              ),
              onPressed: () {},
            ),
          ),
          Container(
              height: 52.0,
              width: 80.0,
              child: RaisedButton(
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 28.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.grey,
                size: 28.0,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final double bmi;
  final double normalBmi;

  ResultCard({Key key, this.bmi = 21.19, this.normalBmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Container(
          width: double.infinity,
          child: Column(children: [
            Text(
              '🔥',
              style: TextStyle(fontSize: 80.0),
            ),
            Text(
              bmi.toStringAsFixed(1),
              style: TextStyle(fontSize: 140.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'BMI = ${bmi.toStringAsFixed(2)} kg/m2',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Normal BMI weight range for the height:\n80kg - 90kg',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
