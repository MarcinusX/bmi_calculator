import 'dart:math' as math;

double calculateBMI({required int height, required int weight}) =>
    weight / _heightSquared(height: height);

double calculateMinNormalWeight({required int height}) =>
    18.5 * _heightSquared(height: height);

double calculateMaxNormalWeight({required int height}) =>
    25 * _heightSquared(height: height);

double _heightSquared({required int height}) =>
    math.pow(height / 100, 2).toDouble();
