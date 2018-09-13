import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';

const TextStyle _titleStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  color: Color.fromRGBO(14, 24, 35, 1.0),
);

const TextStyle _subtitleStyle = TextStyle(
  fontSize: 11.0,
  color: Color.fromRGBO(143, 144, 156, 1.0),
);

class CardTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const CardTitle(this.title, {Key key, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: screenAwareSize(8.0, context),
            left: screenAwareSize(13.0, context),
            right: screenAwareSize(11.0, context),
            bottom: screenAwareSize(8.0, context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: _titleStyle,
              ),
              Text(
                subtitle ?? "",
                style: _subtitleStyle,
              )
            ],
          ),
        ),
        Divider(
          height: 1.0,
          color: Color.fromRGBO(143, 144, 156, 0.22),
        ),
      ],
    );
  }
}
