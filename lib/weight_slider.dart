import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeightSlider extends StatelessWidget {
  WeightSlider({
    Key key,
    @required this.value,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    @required this.width,
  })  : scrollController = new ScrollController(
            initialScrollOffset: (value - minValue) * width / 3),
        super(key: key);

  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<num> onChanged;
  final double width;

  final ScrollController scrollController;

  double get itemExtent => width / 3;

  int _indexToValue(int index) => minValue + (index - 1);

  ///When overscroll occurs on iOS,
  ///we can end up with value not in the range between [minValue] and [maxValue]
  ///To avoid going out of range, we change values out of range to border values.
  int _normalizeMiddleValue(int middleValue) {
    return math.max(math.min(middleValue, maxValue), minValue);
  }

  ///indicates if user has stopped scrolling so we can center value in the middle
  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  animateInt(int valueToSelect, {int durationMillis = 400}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: new Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = _normalizeMiddleValue(middleValue);
    return middleValue;
  }

  bool _onScrollNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);

      if (_userStoppedScrolling(notification)) {
        animateInt(middleValue); //center selected value
      }

      if (middleValue != value) {
        onChanged(middleValue); //update selection
      }
    }
    return true;
  }

  TextStyle _getDefaultTextStyle(BuildContext context) {
    return new TextStyle(
      color: Color.fromRGBO(196, 197, 203, 1.0),
      fontSize: 13.0,
    );
  }

  TextStyle _getHighlightTextStyle(BuildContext context) {
    return new TextStyle(
      color: Color.fromRGBO(77, 123, 243, 1.0),
      fontSize: 27.7,
    );
  }

  TextStyle _getTextStyle(BuildContext context, int itemValue) {
    return itemValue == value
        ? _getHighlightTextStyle(context)
        : _getDefaultTextStyle(context);
  }

  @override
  build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3;
    return new NotificationListener(
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final int value = _indexToValue(index);
          bool isExtra = index == 0 || index == itemCount - 1;

          return isExtra
              ? new Container() //empty first and last element
              : GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => animateInt(value, durationMillis: 50),
                  child: Center(
                    child: new Text(
                      value.toString(),
                      style: _getTextStyle(context, value),
                    ),
                  ),
                );
        },
      ),
      onNotification: _onScrollNotification,
    );
  }
}
