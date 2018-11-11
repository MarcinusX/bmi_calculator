import 'dart:math' as math;

import 'package:bmi_calculator/app_bar.dart';
import 'package:bmi_calculator/fade_route.dart';
import 'package:bmi_calculator/input_page/gender/gender_card.dart';
import 'package:bmi_calculator/input_page/height/height_card.dart';
import 'package:bmi_calculator/input_page/input_page_styles.dart';
import 'package:bmi_calculator/input_page/pacman_slider.dart';
import 'package:bmi_calculator/input_page/weight/weight_card.dart';
import 'package:bmi_calculator/model/gender.dart';
import 'package:bmi_calculator/result_page/result_page.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  InputPageState createState() {
    return new InputPageState();
  }
}

class LoopedSizeAnimation extends Animatable<double> {
  @override
  double transform(double t) {
    if (t < 0.8) {
      return 52.0 + (math.sin(6 * math.pi * t / 0.8)) * 30.0;
    } else {
      return 52 + 5 * (t - 0.8) * 1500.0;
    }
  }
}

class InputPageState extends State<InputPage> with TickerProviderStateMixin {
  AnimationController _submitAnimationController;
  Animation<int> _animatedDotPositionAnimation;
  Animation<double> _animatedDotSizeAnimation;
  Gender gender = Gender.other;
  int height = 170;
  int weight = 70;

  @override
  void initState() {
    super.initState();
    _submitAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animatedDotPositionAnimation =
        IntTween(begin: 0, end: 50).animate(CurvedAnimation(
      parent: _submitAnimationController,
      curve: Interval(0.15, 0.3),
    ));
    _animatedDotSizeAnimation = LoopedSizeAnimation().animate(CurvedAnimation(
        parent: _submitAnimationController, curve: Interval(0.3, 1.0)));
    _submitAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context)
            .push(FadeRoute(
              builder: (context) => ResultPage(
                    weight: weight,
                    height: height,
                    gender: gender,
                  ),
            ))
            .then((_) => _submitAnimationController.reset());
      }
    });
  }

  @override
  void dispose() {
    _submitAnimationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _submitAnimationController,
      builder: (context, child) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor),
              ),
            ),
            _transitionDot(),
            _animatedDotPositionAnimation.value == 0
                ? Scaffold(
                    appBar: PreferredSize(
                      child: BmiAppBar(),
                      preferredSize: Size.fromHeight(appBarHeight(context)),
                    ),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InputSummaryCard(
                          gender: gender,
                          weight: weight,
                          height: height,
                        ),
                        Expanded(child: _buildCards(context)),
                        _buildBottom(context),
                      ],
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }

  Widget _transitionDot() {
    double scaledSize =
        screenAwareSize(_animatedDotSizeAnimation.value, context);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double height = math.min(scaledSize, deviceHeight);
    double width = math.min(scaledSize, deviceWidth);
    Decoration decoration = BoxDecoration(
      borderRadius:
          height < 0.8 * deviceHeight ? BorderRadius.circular(100.0) : null,
      color: Theme.of(context).primaryColor,
    );

    Widget dot = Container(
      decoration: decoration,
      width: width,
      height: height,
    );
    return Center(
      child: Column(
        children: <Widget>[
          Spacer(flex: 101 - _animatedDotPositionAnimation.value),
          dot,
          Spacer(flex: 1 + _animatedDotPositionAnimation.value),
        ],
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: GenderCard(
                  gender: gender,
                  onChanged: (val) => setState(() => gender = val),
                ),
              ),
              Expanded(
                child: WeightCard(
                  weight: weight,
                  onChanged: (val) => setState(() => weight = val),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: HeightCard(
            height: height,
            onChanged: (val) => setState(() => height = val),
          ),
        )
      ],
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenAwareSize(16.0, context),
        right: screenAwareSize(16.0, context),
        bottom: screenAwareSize(22.0, context),
        top: screenAwareSize(14.0, context),
      ),
      child: PacmanSlider(
        submitAnimationController: _submitAnimationController,
        onSubmit: () {
          onPacmanSubmit();
//          Navigator.of(context).push(MaterialPageRoute(
//              builder: (context) => ResultPage(),
//            ));
        },
      ),
    );
  }

  void onPacmanSubmit() {
    _submitAnimationController.forward();
  }
}

class InputSummaryCard extends StatelessWidget {
  final Gender gender;
  final int height;
  final int weight;

  const InputSummaryCard({Key key, this.gender, this.height, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(screenAwareSize(16.0, context)),
      child: SizedBox(
        height: screenAwareSize(32.0, context),
        child: Row(
          children: <Widget>[
            Expanded(child: _genderText()),
            _divider(),
            Expanded(child: _text("${weight}kg")),
            _divider(),
            Expanded(child: _text("${height}cm")),
          ],
        ),
      ),
    );
  }

  Widget _genderText() {
    String genderText = gender == Gender.other
        ? '-'
        : (gender == Gender.male ? 'Male' : 'Female');
    return _text(genderText);
  }

  Widget _text(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(143, 144, 156, 1.0),
        fontSize: 15.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _divider() {
    return Container(
      width: 1.0,
      color: Color.fromRGBO(151, 151, 151, 0.1),
    );
  }
}
