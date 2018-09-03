import 'package:bmi_calculator/card_title.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeightCard extends StatefulWidget {
  @override
  HeightCardState createState() => HeightCardState();
}

class HeightCardState extends State<HeightCard> {
  int height = 170;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle(
              "HEIGHT",
              subtitle: "(cm)",
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenAwareSize(8.0, context)),
                child: LayoutBuilder(builder: (context, constraints) {
                  return HeightPicker(
                    widgetHeight: constraints.maxHeight,
                    height: height,
                    onChange: (val) => setState(() => height = val),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeightPicker extends StatelessWidget {
  final double widgetHeight;
  final int height;
  final ValueChanged<int> onChange;

  static final double circleSize = 32.0;
  static final double bottomMargin = circleSize / 2;
  static final double topMargin = 16.0;
  static final double fontSize = 13.0;
  static final int totalUnits = 190 - 145;

  const HeightPicker({Key key, this.widgetHeight, this.height, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sliderPosition = _sliderPosition(context);
    double personImageHeight =
        sliderPosition + screenAwareSize(circleSize / 2, context);
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset(
            "images/person.svg",
            height: personImageHeight,
            width: personImageHeight / 3,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: _drawLabels(context),
        ),
        Positioned(
          child: _drawSlider(),
          left: 0.0,
          right: 0.0,
          bottom: _sliderPosition(context),
        )
      ],
    );
  }

  double _sliderPosition(BuildContext context) {
    double drawingHeight = widgetHeight -
        screenAwareSize(bottomMargin + topMargin, context) -
        fontSize;
    double heightPerUnit = drawingHeight / totalUnits;
    return heightPerUnit * (height - 145);
  }

  Widget _drawLabels(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: screenAwareSize(12.0, context),
        bottom: screenAwareSize(bottomMargin, context),
        top: screenAwareSize(topMargin, context),
      ),
      child: Column(
        children: List.generate(
          10,
          (idx) {
            return Text(
              "${190 - 5 * idx}",
              style: TextStyle(
                color: Color.fromRGBO(216, 217, 223, 1.0),
                fontSize: fontSize,
              ),
            );
          },
        ),
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _drawSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$height"),
        Row(
          children: <Widget>[
            SliderCircle(),
            Expanded(child: SliderLine()),
          ],
        ),
      ],
    );
  }
}

class SliderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
          40,
          (i) => Expanded(
                child: Container(
                  height: 2.0,
                  decoration: BoxDecoration(
                      color: i.isEven
                          ? Color.fromRGBO(77, 123, 243, 1.0)
                          : Colors.white),
                ),
              )),
    );
  }
}

class SliderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenAwareSize(32.0, context),
      height: screenAwareSize(32.0, context),
      decoration: BoxDecoration(
        color: Color.fromRGBO(77, 123, 243, 1.0),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.unfold_more,
        color: Colors.white,
        size: screenAwareSize(24.0, context),
      ),
    );
  }
}
