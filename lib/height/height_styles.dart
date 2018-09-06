export 'package:bmi_calculator/styles.dart';

import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';

double circleSizeAdapted(BuildContext context) => screenAwareSize(circleSize, context);
double marginBottomAdapted(BuildContext context) => screenAwareSize(marginBottom, context);
double marginTopAdapted(BuildContext context) => screenAwareSize(marginTop, context);
const double circleSize = 32.0;
const double marginBottom = circleSize / 2;
const double marginTop = 26.0;
const double selectedLabelFontSize = 14.0;
const double labelsFontSize = 13.0;
const Color labelsGrey = const Color.fromRGBO(216, 217, 223, 1.0);