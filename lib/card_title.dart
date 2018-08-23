import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String title;
  final String subTitle;

  const CardTitle(this.title, {Key key, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: new TextSpan(
        text: title,
        style: new TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(14, 24, 35, 1.0),
        ),
        children: <TextSpan>[
          new TextSpan(
            text: subTitle ?? "",
            style: new TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(78, 102, 114, 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
