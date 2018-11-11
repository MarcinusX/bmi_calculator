import 'dart:math' as math;

double calculateBMI({int height, int weight}) =>
    weight / _heightSquared(height);

double calculateMinNormalWeight({int height}) => 18.5 * _heightSquared(height);

double calculateMaxNormalWeight({int height}) => 25 * _heightSquared(height);

double _heightSquared(int height) => math.pow(height / 100, 2);
