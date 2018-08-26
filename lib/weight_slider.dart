import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeightSlider extends StatefulWidget {
  WeightSlider.integer({
    Key key,
    @required this.value,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    @required this.width,
  })  : scrollController = new ScrollController(
          initialScrollOffset: (value - minValue) * width / 3,
        ),
        super(key: key);

  final ValueChanged<num> onChanged;
  final int minValue;
  final int maxValue;
  final double width;
  final ScrollController scrollController;
  final int value;

  double get itemExtent => width / 3;

  animateInt(int valueToSelect) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: new Duration(seconds: 1),
      curve: new ElasticOutCurve(),
    );
  }

  @override
  WeightSliderState createState() {
    return new WeightSliderState();
  }

  int _indexToValue(int index) => minValue + (index - 1);

  bool _onIntegerNotification(Notification notification) {
    if (notification is ScrollNotification) {
      //calculate
      int intIndexOfMiddleElement =
          (notification.metrics.pixels + width / 2) ~/ itemExtent;
      int intValueInTheMiddle = _indexToValue(intIndexOfMiddleElement);
      intValueInTheMiddle = _normalizeIntegerMiddleValue(intValueInTheMiddle);

      if (_userStoppedScrolling(notification, scrollController)) {
        //center selected value
        animateInt(intValueInTheMiddle);
      }

      //update selection
      if (intValueInTheMiddle != value) {
        num newValue;
        newValue = (intValueInTheMiddle);

        onChanged(newValue);
      }
    }
    return true;
  }

  ///When overscroll occurs on iOS,
  ///we can end up with value not in the range between [minValue] and [maxValue]
  ///To avoid going out of range, we change values out of range to border values.
  int _normalizeMiddleValue(int valueInTheMiddle, int min, int max) {
    return math.max(math.min(valueInTheMiddle, max), min);
  }

  int _normalizeIntegerMiddleValue(int integerValueInTheMiddle) {
    return _normalizeMiddleValue(integerValueInTheMiddle, minValue, maxValue);
  }

  ///indicates if user has stopped scrolling so we can center value in the middle
  bool _userStoppedScrolling(
      Notification notification, ScrollController scrollController) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }
}

class WeightSliderState extends State<WeightSlider> {
  ///main widget
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    TextStyle defaultStyle = themeData.textTheme.body1;
    TextStyle selectedStyle =
        themeData.textTheme.headline.copyWith(color: themeData.accentColor);
    int itemCount = (widget.maxValue - widget.minValue) + 3;

    return new NotificationListener(
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: widget.scrollController,
        itemExtent: widget.itemExtent,
        itemCount: itemCount,
        physics: new BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final int value = widget._indexToValue(index);

          //define special style for selected (middle) element
          final TextStyle itemStyle =
              value == widget.value ? selectedStyle : defaultStyle;

          bool isExtra = index == 0 || index == itemCount - 1;

          return isExtra
              ? new Container() //empty first and last element
              : GestureDetector(
                  onTap: () => widget.animateInt(value),
                  child: new Center(
                    child: new Text(value.toString(), style: itemStyle),
                  ),
                );
        },
      ),
      onNotification: widget._onIntegerNotification,
    );
  }
}
